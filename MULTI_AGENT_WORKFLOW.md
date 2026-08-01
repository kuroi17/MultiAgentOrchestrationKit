# Standard Operating Procedure: Multi-Agent Software Development Workflow

**Document Version:** 4.0.0 (State-Aware Edition)  
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

## 3. Persistent Project State Layer 🧠

To ensure seamless resiliency across long-running projects, chat context resets, and new conversations, Antigravity maintains a persistent state structure in `.agent_state/` (or project root):

```
Project/
├── MULTI_AGENT_WORKFLOW.md   (Standard Operating Procedure)
├── implementation_plan.md    (Current roadmap & task breakdown)
├── architecture.md           (System design & module boundaries)
├── decisions.md              (Architectural Decision Records - ADRs)
├── iteration_history.json    (Machine-readable execution & audit log)
├── walkthrough.md            (Human-readable milestone summary)
└── project_state.md          (Lean index: current milestone, active mode, last completed iteration)
```

### Purpose of Core State Files:
- **`project_state.md` (Primary Index):** A lightweight (<30 lines) status file. Antigravity reads this FIRST upon session start to instantly reconstruct project context without reading full chat history.
- **`implementation_plan.md`:** Current active roadmap and task decomposition.
- **`architecture.md`:** Module relationships and interface contracts.
- **`decisions.md`:** Important engineering decisions and trade-offs.
- **`iteration_history.json`:** Chronological audit trail of all execution cycles, test pass rates, and review findings.

---

## 4. Context Reconstruction Protocol

Before initiating ANY planning, execution, or review cycle, Antigravity must execute the **Context Reconstruction Protocol**:

```
                       Session Start / New Chat
                                   │
                                   ▼
                   1. Read project_state.md (Lean Index)
                                   │
                                   ▼
                   2. Reconstruct Context & Active Mode
                                   │
                                   ▼
                   3. Planning / Execution (Mode 4 or Mode 5)
                                   │
                                   ▼
                   4. Code Generation via Desktop Bridge
                                   │
                                   ▼
                   5. QA & Code Review Audit
                                   │
                                   ▼
                   6. Update State Files (project_state.md, history)
                                   │
                                   ▼
                   7. Continuous Advancement (Next Iteration)
```

---

## 5. Dual Execution Modes Overview

Developers can select between two flexible operating modes depending on project needs:

| Operating Mode | Protocol | Ideal Use Cases | Execution Pattern |
| :--- | :--- | :--- | :--- |
| **Mode 4** | **Pre-Planned Multi-Step Loop** | Standard features, CRUD modules, predictable task lists | Executes a fixed sequence of tasks ($T_1 \rightarrow T_2 \rightarrow T_3$) continuously via live pop-ups. |
| **Mode 5** | **Self-Correcting Quality Loop** | Complex algorithms, refactoring, fuzzy requirements, security audits | Antigravity conducts deep code audits, categorizes findings (`Critical`/`Recommended`), and **dynamically generates self-correction tasks** until DoD is achieved. |

---

## 6. Mode 4: Pre-Planned Multi-Step Loop Protocol

1. **Context Reconstruction:** Antigravity reads `project_state.md` and `implementation_plan.md`.
2. **Task Spawning:** Posts Iteration $N$ prompt to the Desktop Bridge queue.
3. **Live Desktop Streaming:** `gui_bridge.ps1` pops up a visible terminal titled `ANTIGRAVITY LIVE STREAM [ITERATION N] - Task Title`.
4. **Verification & State Update:** As soon as OpenCode exits, Antigravity runs test suites, updates `iteration_history.json` and `project_state.md`, and advances to Iteration $N+1$.

---

## 7. Mode 5: Self-Correcting Autonomous Quality Loop Protocol

1. **Context Reconstruction:** Antigravity reads `project_state.md`.
2. **Execution & Audit:** OpenCode executes task; Antigravity inspects diffs and test results.
3. **Decision Gate:**
   - **Option A (DoD Achieved):** Update `project_state.md` to `STATUS: DONE` and summarize completion.
   - **Option B (Improvements Required):** Categorize findings (`Critical`/`Recommended`), update `iteration_history.json`, generate dynamic improvement task $N+1$, and post to GUI Bridge!
4. **Review Classification Rules:**
   - **Critical (Must Fix):** Bugs, test failures, security flaws ➔ Triggers Cycle $N+1$.
   - **Recommended (High Value):** Architecture, validation hardening ➔ Triggers Cycle $N+1$.
   - **Optional (Minor):** Naming/formatting ➔ Logged only; **does NOT trigger new iteration**.

---

## 8. Definition of Done (DoD)

A milestone is considered **DONE** if and only if:
- [ ] Source files exist in the specified project directory.
- [ ] Accompanying unit test files exist.
- [ ] Unit tests pass with 0 failures and 0 errors.
- [ ] No Critical or Recommended issues remain.
- [ ] `project_state.md` and `iteration_history.json` are updated.
- [ ] Walkthrough documentation (`walkthrough.md`) has been updated.

---

## 9. Global Quick-Start Guide for Any Project Repository

To use this workflow in any new conversation or workspace:
1. **Launch Desktop Bridge Once Globally:**  
   Open a terminal tab and run:  
   `cd "C:\Users\HP LAPTOP 15s\.gemini\antigravity-ide\scratch"; .\gui_bridge.ps1`
2. **Instruct Antigravity in Any New Chat:**  
   - **"Follow MULTI_AGENT_WORKFLOW.md in Mode 4 to build [GOAL]."**
   - OR
   - **"Follow MULTI_AGENT_WORKFLOW.md in Mode 5 to build [GOAL]."**
3. **Instant Context Resumption:**  
   If starting a new chat on an existing project, say:  
   **"Resume project using MULTI_AGENT_WORKFLOW.md."**  
   Antigravity will read `project_state.md` and pick up right where you left off!
