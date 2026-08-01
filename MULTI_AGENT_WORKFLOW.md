# Standard Operating Procedure: Multi-Agent Software Development Workflow

**Document Version:** 6.0.0 (Project Lifecycle Manager Edition)  
**Target Agents:** Antigravity (Lead Architect, Project Manager & QA Orchestrator) & OpenCode / CLI Execution Agents  
**Scope:** Reusable engineering manual for multi-agent software development across any project repository.

---

## 1. Purpose & Philosophy

Modern AI-assisted software development requires clear separation of concerns. Running a single LLM to simultaneously handle high-level architectural planning, file system edits, token-heavy code generation, and iterative debugging leads to context bloat, degraded reasoning, and unnecessary API token costs.

This **Multi-Agent Workflow** decouples high-level reasoning from low-level code generation:
- **Antigravity** acts as the high-level **Chief Architect, Project Manager, Reviewer, and QA Orchestrator**, managing the complete software project lifecycle across milestones while maintaining a lean context window.
- **CLI Execution Agents (OpenCode, Claude Code, etc.)** act as specialized **Execution Workers**, performing localized file modifications, heavy code generation, and fast refactoring in isolated CLI subprocesses.
- **The User** acts as the **Product Owner & Director**, approving architectural plans and reviewing incremental milestone deliverables.

---

## 2. Roles & Responsibilities

| Role | Agent / Entity | Core Responsibilities |
| :--- | :--- | :--- |
| **Product Owner** | **User** | Defines high-level project goals, approves milestone plans, monitors progress dashboards, and accepts final project deliverables. |
| **Lead Architect & Project Manager** | **Antigravity** | Decomposes project goals into logical milestones ($M_1, M_2, M_3$), formulates implementation plans, manages state transitions, spawns CLI execution agents, performs QA code audits, and generates retrospectives. |
| **Execution Agent** | **OpenCode / CLI Agent** | Receives task prompts from Antigravity, generates source code and unit tests, performs inline refactoring, and reports completion results. |

---

## 3. Project Lifecycle Hierarchy 🏗️

Antigravity operates on a top-down project hierarchy:

```
                          PROJECT GOAL
                               │
       ┌───────────────────────┼───────────────────────┐
       ▼                       ▼                       ▼
  MILESTONE 1             MILESTONE 2             MILESTONE 3
 (Core Engine)           (Features)              (CLI / UI)
       │                       │                       │
 ┌─────┴─────┐           ┌─────┴─────┐           ┌─────┴─────┐
 ▼           ▼           ▼           ▼           ▼           ▼
Task 1      Task 2      Task 1      Task 2      Task 1      Task 2
 │           │           │           │           │           │
 ▼           ▼           ▼           ▼           ▼           ▼
Review      Review      Review      Review      Review      Review
```

---

## 4. Milestone Planning & Health Dashboard 📊

### Standard State File Structure (`.agent_state/` or project root):
```
Project/
├── MULTI_AGENT_WORKFLOW.md      (Protocol Manual v6.0.0)
├── project_state.md             (Single Source of Truth Index)
├── milestone_plan.md            (Project milestone decomposition & ordering)
├── milestone_status.md          (Live progress & health dashboard)
├── implementation_plan.md       (Current active milestone roadmap)
├── architecture_decisions.md    (Cross-milestone ADR memory)
├── iteration_history.json       (Machine-readable audit trail)
├── walkthrough.md               (Human-readable progress log)
└── project_retrospective.md     (Final project retrospective summary)
```

### 1. `milestone_plan.md` Schema:
Decomposes the project into ordered milestones before coding begins:
- Milestone Name & Goal
- Dependencies & Execution Order
- Estimated Task Count
- Definition of Done (DoD)

### 2. `milestone_status.md` Dashboard Schema:
- **Project Progress:** `[████████░░░░] 60%`
- **Active Milestone:** `Milestone 2: CRUD Engine`
- **Status:** `IN_PROGRESS`
- **Blockers / Risks:** `None`

---

## 5. Automatic Milestone Progression Protocol

Once a milestone satisfies its Definition of Done:

```
  [MILESTONE N EXECUTED & VERIFIED] ──► [TRANSITION GATE VERIFICATION]
                                                      │
                                                      ▼
  [SELECT NEXT MILESTONE N+1] ◄── [UPDATE STATE & DASHBOARD: M_N COMPLETED]
              │
              ▼
  [GENERATE IMPLEMENTATION PLAN N+1] ──► [AUTO-ADVANCE TO EXECUTION]
```

### Milestone Transition Gate Verification:
Before advancing to Milestone $N+1$, Antigravity automatically checks:
- [ ] Previous milestone Pytest suite passes 100%.
- [ ] No Critical or Recommended issues remain.
- [ ] `architecture_decisions.md` updated with new ADRs.
- [ ] `project_state.md` and `milestone_status.md` updated.

---

## 6. Cross-Milestone Memory (`architecture_decisions.md`) 🧠

To ensure architectural consistency across long-running milestones, Antigravity records and consults **Architecture Decision Records (ADRs)**:
- Coding & naming conventions
- Module boundaries & file structure
- Reusable utilities & helper patterns
- Testing strategy

Every new milestone planning cycle **must consult `architecture_decisions.md`** before decomposing tasks.

---

## 7. Project Completion & Retrospective Protocol 🏆

When all milestones are completed, Antigravity generates **`project_retrospective.md`**:
- **What Was Built:** High-level summary of deliverables.
- **Key Architectural Decisions:** Summary of ADRs.
- **QA & Testing Statistics:** Total unit tests, pass rates, and cycle counts.
- **Autonomous Execution Metrics:** Number of OpenCode executions and self-corrections.

---

## 8. Dual Execution Modes Overview

Within each milestone task, developers can choose between two execution protocols:

| Mode | Name | Best Used For | Execution Pattern |
| :--- | :--- | :--- | :--- |
| **Mode 4** | **Pre-Planned Multi-Step Loop** | Standard features, CRUD modules | Sequential task execution ($T_1 \rightarrow T_2 \rightarrow T_3$) via live bridge. |
| **Mode 5** | **Self-Correcting Quality Loop** | Complex algorithms, refactoring | Dynamic Planner ➔ Executor ➔ Reviewer ➔ Decision Gate loop. |

---

## 9. Atomic State Write Protocol & Crash Recovery

1. **Atomic Writes:** Updates to `project_state.md`, `milestone_status.md`, and `iteration_history.json` are committed **only AFTER verification passes 100%**.
2. **Crash Recovery:** If a crash or session reset occurs, saying **"Resume project using MULTI_AGENT_WORKFLOW.md"** reads `project_state.md`, detects the active milestone/task, and resumes execution seamlessly!

---

## 10. Global Quick-Start Guide for Any Project Repository

To run a project with full lifecycle management:
1. **Launch Desktop Bridge Once Globally:**  
   Open a terminal tab and run:  
   `cd "C:\Users\HP LAPTOP 15s\.gemini\antigravity-ide\scratch"; .\gui_bridge.ps1`
2. **Instruct Antigravity in Any Workspace:**  
   **"Follow MULTI_AGENT_WORKFLOW.md in Mode 5 to build [PROJECT_GOAL]."**
3. **Milestone Approval:**  
   Antigravity generates `milestone_plan.md`. Upon your approval, Antigravity executes milestones $M_1 \rightarrow M_2 \rightarrow M_3$ continuously, updating the live dashboard and popping up streaming terminal windows automatically!
