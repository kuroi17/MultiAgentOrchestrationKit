# Standard Operating Procedure: Multi-Agent Software Development Workflow

**Document Version:** 5.0.0 (Autonomous State Manager Edition)  
**Target Agents:** Antigravity (Lead Architect & QA Orchestrator) & OpenCode / CLI Execution Agents  
**Scope:** Reusable engineering manual for multi-agent software development across any project repository.

---

## 1. Purpose & Philosophy

Modern AI-assisted software development requires clear separation of concerns. Running a single LLM to simultaneously handle high-level architectural planning, file system edits, token-heavy code generation, and iterative debugging leads to context bloat, degraded reasoning, and unnecessary API token costs.

This **Multi-Agent Workflow** decouples high-level reasoning from low-level code generation:
- **Antigravity** acts as the high-level **Chief Architect, Planner, Reviewer, and QA Orchestrator**, maintaining a lean context window focused on project goals and system integrity.
- **CLI Execution Agents (OpenCode, Claude Code, etc.)** act as specialized **Execution Workers**, performing localized file modifications, heavy code generation, and fast refactoring in isolated CLI subprocesses.
- **The User** acts as the **Product Owner & Director**, approving architectural plans and reviewing incremental milestones.

---

## 2. Roles & Responsibilities

| Role | Agent / Entity | Core Responsibilities |
| :--- | :--- | :--- |
| **Product Owner** | **User** | Defines project requirements, approves implementation plans, monitors progress, and validates milestone deliverables. |
| **Lead Architect & Orchestrator** | **Antigravity** | Analyzes user requirements, formulates implementation plans, decomposes work into atomic task prompts, spawns execution agents via CLI, performs code reviews, runs verification suites, and manages project state. |
| **Execution Agent** | **OpenCode / CLI Agent** | Receives task prompts from Antigravity, generates source files and unit tests, performs inline refactoring, and reports completion results. |

---

## 3. Autonomous State Manager Architecture (Single Source of Truth) 🧠

In Version 5.0.0, **`project_state.md`** serves as the **Single Source of Truth (SSOT)** for project progress. Antigravity automatically persists state updates after every verified execution cycle.

### Standard State Schema (`project_state.md`):
```markdown
# 🔄 Autonomous Project State
**Project Name:** [PROJECT_NAME]
**Active Mode:** [Mode 4 (Pre-Planned) / Mode 5 (Self-Correcting)]
**Current Milestone:** [MILESTONE_NAME]
**Current Cycle / Iteration:** [CYCLE_N / TOTAL]
**Current Status:** [PLANNING / EXECUTING / REVIEWING / WAITING / COMPLETED]
**Current Task:** [ACTIVE_TASK_NAME]
**Last Completed Task:** [PREVIOUS_TASK_NAME]
**Next Planned Task:** [NEXT_TASK_NAME]
**Outstanding Critical Issues:** [COUNT / NONE]
**Outstanding Recommended Issues:** [COUNT / NONE]
**Git Branch:** [BRANCH_NAME]
**Last Updated:** [TIMESTAMP_ISO]
```

### Complete State File Map:
- **`project_state.md` (SSOT Index):** Lightweight status dashboard (<30 lines) read on session start.
- **`implementation_plan.md`:** Detailed task roadmap and component decomposition.
- **`architecture.md`:** System architecture, module boundaries, and interfaces.
- **`decisions.md`:** Architectural Decision Records (ADRs).
- **`iteration_history.json`:** Chronological machine-readable audit trail of execution outputs, test pass rates, and review findings.
- **`walkthrough.md`:** Human-readable progress log with file links and verification diffs.

---

## 4. Atomic State Write Protocol & Crash Recovery

To prevent partial, corrupted, or stale state:

1. **Atomic Writes:** State updates (`project_state.md`, `iteration_history.json`, `walkthrough.md`) are written **only AFTER Pytest test suites pass 100% and verification completes**.
2. **Crash Recovery & Auto-Resume Check:**  
   When starting a new session or after an unexpected exit, Antigravity executes the **Resume Protocol**:
   - Read `project_state.md`.
   - Check `Current Status`.
   - If `Status != COMPLETED`, resume automatically from the last verified checkpoint.
   - If `Status == COMPLETED`, prompt for the next project milestone.

---

## 5. State Transition Rules

Every cycle enforces the following strict state transitions:

```
  [PLANNING] ──► [EXECUTING] ──► [REVIEWING] ──► [ATOMIC STATE WRITE] ──► [NEXT CYCLE]
      ▲                                                                         │
      └──────────────────────────── (Auto-Resume Check) ────────────────────────┘
```

No cycle may begin without a valid verified state checkpoint.

---

## 6. Dual Execution Modes Overview

Developers can select between two flexible operating modes depending on project needs:

| Operating Mode | Protocol | Ideal Use Cases | Execution Pattern |
| :--- | :--- | :--- | :--- |
| **Mode 4** | **Pre-Planned Multi-Step Loop** | Standard features, CRUD modules, predictable task lists | Executes a fixed sequence of tasks ($T_1 \rightarrow T_2 \rightarrow T_3$) continuously via live pop-ups. |
| **Mode 5** | **Self-Correcting Quality Loop** | Complex algorithms, refactoring, fuzzy requirements, security audits | Antigravity conducts deep code audits, categorizes findings (`Critical`/`Recommended`), and **dynamically generates self-correction tasks** until DoD is achieved. |

---

## 7. Mode 4: Pre-Planned Multi-Step Loop Protocol (State-Managed)

1. **Resume Check:** Antigravity reads `project_state.md` and `implementation_plan.md`.
2. **Status Update:** Set `Current Status = EXECUTING` in `project_state.md`.
3. **Desktop Bridge Spawning:** Post Iteration $N$ task prompt to the Desktop Bridge queue.
4. **Live Desktop Streaming:** `gui_bridge.ps1` pops up a visible terminal titled `ANTIGRAVITY LIVE STREAM [ITERATION N] - Task Title`.
5. **Verification & Atomic State Write:**  
   Once OpenCode finishes:
   - Run Pytest test suite.
   - Append audit log to `iteration_history.json`.
   - Update `project_state.md` (`Last Completed Task`, `Current Status = PLANNING` for $N+1$).
   - Advance to Iteration $N+1$.

---

## 8. Mode 5: Self-Correcting Quality Loop Protocol (State-Managed)

1. **Resume Check:** Antigravity reads `project_state.md`.
2. **Execution & Audit:** OpenCode executes task; Antigravity inspects diffs and test results.
3. **Decision Gate & State Classification:**
   - **Option A (DoD Achieved):** Set `Current Status = COMPLETED` in `project_state.md` and write `walkthrough.md`.
   - **Option B (Improvements Required):**  
     - Categorize findings (`Critical` / `Recommended`).
     - Append findings to `iteration_history.json`.
     - Update `project_state.md` with `Outstanding Critical Issues` count.
     - Generate dynamic improvement task $N+1$ and post to GUI Bridge!
4. **Review Classification Rules:**
   - **Critical (Must Fix):** Bugs, test failures, security flaws ➔ Triggers Cycle $N+1$.
   - **Recommended (High Value):** Architecture, validation hardening ➔ Triggers Cycle $N+1$.
   - **Optional (Minor):** Naming/formatting ➔ Logged only; **does NOT trigger new iteration**.

---

## 9. Definition of Done (DoD)

A milestone is complete only when:
- [ ] Source files exist in the specified project directory.
- [ ] Accompanying unit test files exist.
- [ ] Unit tests pass with 0 failures and 0 errors.
- [ ] No Critical or Recommended issues remain.
- [ ] Atomic state write completed (`project_state.md` status set to `COMPLETED`).
- [ ] `iteration_history.json` and `walkthrough.md` updated.

---

## 10. Global Quick-Start & Auto-Resume Guide

To use this workflow in any new conversation or workspace:
1. **Launch Desktop Bridge Once Globally:**  
   Open a terminal tab and run:  
   `cd "C:\Users\HP LAPTOP 15s\.gemini\antigravity-ide\scratch"; .\gui_bridge.ps1`
2. **Instruct Antigravity in Any New Chat:**  
   - **"Follow MULTI_AGENT_WORKFLOW.md in Mode 4 to build [GOAL]."**
   - OR
   - **"Follow MULTI_AGENT_WORKFLOW.md in Mode 5 to build [GOAL]."**
3. **Automatic Crash Recovery & Resume:**  
   In any new chat or after a session reset, simply say:  
   **"Resume project using MULTI_AGENT_WORKFLOW.md."**  
   Antigravity will read `project_state.md`, detect the exact active checkpoint, and resume execution seamlessly!
