# Standard Operating Procedure: Multi-Agent Software Development Workflow

**Document Version:** 3.0.0 (Dual-Mode Edition)  
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

## 3. Dual Execution Modes Overview

Developers can select between two flexible operating modes depending on project needs:

| Operating Mode | Protocol | Ideal Use Cases | Execution Pattern |
| :--- | :--- | :--- | :--- |
| **Mode 4** | **Pre-Planned Multi-Step Loop** | Standard features, CRUD modules, predictable task lists | Executes a fixed sequence of tasks ($T_1 \rightarrow T_2 \rightarrow T_3$) continuously via live pop-ups. |
| **Mode 5** | **Self-Correcting Quality Loop** | Complex algorithms, refactoring, fuzzy requirements, security audits | Antigravity conducts deep code audits, categorizes findings (`Critical`/`Recommended`), and **dynamically generates self-correction tasks** until DoD is achieved. |

---

## 4. Mode 4: Pre-Planned Multi-Step Loop Protocol

```
+-----------------------------------------------------------------------------------+
| 1. Requirements & Planning (User <-> Antigravity)                                  |
+-----------------------------------------+-----------------------------------------+
                                          |
                                          v
+-----------------------------------------------------------------------------------+
| 2. Architectural Review & Plan Approval (User Approves implementation_plan.md)     |
+-----------------------------------------+-----------------------------------------+
                                          |
                                          v
+-----------------------------------------------------------------------------------+
| 3. Task Decomposition (Antigravity prepares atomic task instructions)             |
+-----------------------------------------+-----------------------------------------+
                                          |
                                          v
+-----------------------------------------------------------------------------------+
| 4. Desktop Bridge Spawning (Antigravity posts task -> Bridge pops up terminal)    |
+-----------------------------------------+-----------------------------------------+
                                          |
                                          v
+-----------------------------------------------------------------------------------+
| 5. Live Process Streaming (User watches OpenCode code generation live on screen)  |
+-----------------------------------------+-----------------------------------------+
                                          |
                                          v
+-----------------------------------------------------------------------------------+
| 6. QA & Verification (Antigravity runs tests, inspects diffs, verifies DoD)        |
+-----------------------------------------+-----------------------------------------+
                                          |
                                          v
+-----------------------------------------------------------------------------------+
| 7. Continuous Autonomous Advancement (Antigravity posts Iteration N+1 until done)  |
+-----------------------------------------------------------------------------------+
```

---

## 5. Mode 5: Self-Correcting Autonomous Quality Loop Protocol

```
                                  User Input
                                      │
                                      ▼
                            Planning & Architecture
                                      │
                                      ▼
                            OpenCode Execution
                                      │
                                      ▼
                            Antigravity Review & Audit
                                      │
                                      ▼
                                Decision Gate
                   ┌──────────────────┴──────────────────┐
                   ▼                                     ▼
      Option A: DoD Achieved                Option B: Improvements Required
        (Finish & Report)                        (Categorize Findings:
                                                 Critical / Recommended)
                                                         │
                                                         ▼
                                             Generate Improvement Task
                                                         │
                                                         ▼
                                            Launch OpenCode via Bridge
                                                         │
                                                         ▼
                                             Execute & Review Again
```

### Review Classification Rules (Preventing Endless Polishing):
- **Critical (Must Fix):** Failing tests, bugs, security issues, broken contracts ➔ Triggers Cycle $N+1$.
- **Recommended (High Value):** Design pattern improvements, validation hardening ➔ Triggers Cycle $N+1$.
- **Optional (Minor):** Cosmetic naming, trivial comments ➔ Logged only; **does NOT trigger new iteration**.

---

## 6. Definition of Done (DoD)

A task/milestone is considered **DONE** if and only if:
- [ ] Source files exist in the specified project directory.
- [ ] Accompanying unit test files exist.
- [ ] Unit tests pass with 0 failures and 0 errors.
- [ ] No Critical or Recommended issues remain.
- [ ] Code adheres to type safety and documentation standards.
- [ ] Antigravity has performed visual/diff code inspection.
- [ ] Walkthrough documentation (`walkthrough.md`) has been updated.

---

## 7. Global Quick-Start Guide for Any Project Repository

To use this workflow in any new conversation or workspace:
1. **Launch Desktop Bridge Once Globally:**  
   Open a terminal tab and run:  
   `cd "C:\Users\HP LAPTOP 15s\.gemini\antigravity-ide\scratch"; .\gui_bridge.ps1`
2. **Instruct Antigravity in Any New Chat:**  
   - For Pre-Planned tasks: **"Follow MULTI_AGENT_WORKFLOW.md in Mode 4 to build [GOAL]."**
   - For Self-Correcting tasks: **"Follow MULTI_AGENT_WORKFLOW.md in Mode 5 to build [GOAL]."**
3. **Automatic Directory & Live Streaming:**  
   Antigravity automatically passes the target project CWD and task payload to the central bridge, popping up live PowerShell windows with window title iteration indicators (`[CYCLE N]`)!
