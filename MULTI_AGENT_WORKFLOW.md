# Standard Operating Procedure: Multi-Agent Software Development Workflow

**Document Version:** 7.0.0 (Dependency Graph & Parallel Planning Edition)  
**Target Agents:** Antigravity (Lead Architect, DAG Orchestrator & QA Manager) & OpenCode / CLI Execution Agents  
**Scope:** Reusable engineering manual for multi-agent software development across any project repository.

---

## 1. Purpose & Philosophy

Modern AI-assisted software development requires clear separation of concerns. Running a single LLM to simultaneously handle high-level architectural planning, file system edits, token-heavy code generation, and iterative debugging leads to context bloat, degraded reasoning, and unnecessary API token costs.

This **Multi-Agent Workflow** decouples high-level reasoning from low-level code generation:
- **Antigravity** acts as the high-level **Chief Architect, DAG Orchestrator, Reviewer, and QA Manager**, maintaining a lean context window focused on project goals, task dependency graphs, and critical path analysis.
- **CLI Execution Agents (OpenCode, Claude Code, etc.)** act as specialized **Execution Workers**, performing localized file modifications, heavy code generation, and fast refactoring in isolated CLI subprocesses.
- **The User** acts as the **Product Owner & Director**, approving architectural plans and reviewing incremental milestone deliverables.

---

## 2. Roles & Responsibilities

| Role | Agent / Entity | Core Responsibilities |
| :--- | :--- | :--- |
| **Product Owner** | **User** | Defines high-level project goals, approves milestone DAG graphs, monitors dashboards, and accepts final project deliverables. |
| **DAG Orchestrator & Lead Architect** | **Antigravity** | Decomposes milestones into Directed Acyclic Graphs (DAGs), calculates critical paths, schedules `READY` tasks, conducts QA code audits, and manages project state transitions. |
| **Execution Agent** | **OpenCode / CLI Agent** | Receives task prompts from Antigravity, generates source code and unit tests, performs inline refactoring, and reports completion results. |

---

## 3. Project Lifecycle Hierarchy & DAG Topology 🕸️

In Version 7.0.0, tasks are no longer simple linear arrays. Antigravity models every milestone as a **Directed Acyclic Graph (DAG)**:

```
                          PROJECT GOAL
                               │
       ┌───────────────────────┼───────────────────────┐
       ▼                       ▼                       ▼
  MILESTONE 1             MILESTONE 2             MILESTONE 3
       │
       ▼
 ┌───────────┐
 │ T1: Core  │
 └─────┬─────┘
       │
 ┌─────┴───────────────┐
 ▼                     ▼
┌──────────────┐ ┌──────────────┐
│ T2: Manager  │ │ T3: Storage  │
└──────┬───────┘ └──────┬───────┘
       │                │
       └───────┬────────┘
               ▼
        ┌──────────────┐
        │ T4: CLI App  │ (Parallelizable Foundation)
        └──────────────┘
```

---

## 4. Dependency Graph & Scheduler Files 📊

### Standard State File Structure (`.agent_state/` or project root):
```
Project/
├── MULTI_AGENT_WORKFLOW.md      (Protocol Manual v7.0.0)
├── project_state.md             (Single Source of Truth Index)
├── milestone_plan.md            (Milestone decomposition & ordering)
├── milestone_status.md          (Live progress & health dashboard)
├── dependency_graph.md          (DAG Task Node Map & relationships)
├── critical_path.md             (Critical Path Analysis & bottlenecks)
├── scheduler_state.md           (Queue status: BLOCKED, READY, RUNNING, COMPLETE)
├── scheduler_log.md             (Chronological task dispatch log)
├── implementation_plan.md       (Active milestone task roadmap)
├── architecture_decisions.md    (Cross-milestone ADR memory)
├── iteration_history.json       (Machine-readable audit trail)
├── walkthrough.md               (Human-readable progress log)
└── project_retrospective.md     (Final project retrospective summary)
```

### 1. `dependency_graph.md` Schema:
Models task nodes and explicit prerequisite relationships:
- Task Node ID (`T1`, `T2`, `T3`)
- Prerequisites (`Depends On`)
- Dependents (`Unblocks`)
- Execution Agent Assigned
- Parallelizability Tag (`PARALLELIZABLE` / `SEQUENTIAL`)

### 2. `critical_path.md` Schema:
Calculates the longest dependency chain and estimated completion timeline:
- **Critical Path Chain:** `T1: Core -> T2: Manager -> T4: CLI App`
- **Bottleneck Node:** `T2: Manager`
- **Estimated Completion Path:** 3 Cycles

---

## 5. Task Scheduler State Machine

Antigravity manages task states using a 5-stage state machine:

```
  [BLOCKED] ──(Prerequisites Met)──► [READY] ──(Dispatched)──► [RUNNING]
                                                                  │
  [COMPLETE] ◄──(DoD Verified)─── [REVIEWING] ◄──(Code Written)───┘
```

### Scheduling Rules:
1. **BLOCKED:** Task has uncompleted prerequisite dependencies.
2. **READY:** All prerequisite tasks are `COMPLETE`. Can be scheduled immediately.
3. **RUNNING:** Task dispatched to OpenCode CLI via Desktop GUI Bridge.
4. **REVIEWING:** OpenCode finished; Antigravity conducting QA audit.
5. **COMPLETE:** QA passed 100%; unblocks dependent downstream tasks.

---

## 6. Critical Path Analysis & Parallel Readiness (v8 Foundation)

Antigravity tags all `READY` tasks without mutual dependencies as `PARALLELIZABLE`.  
In Version 7, `PARALLELIZABLE` tasks are executed in optimal sequence. In **Version 8**, Antigravity will dispatch them simultaneously to multiple workers (Worker A, Worker B, Worker C)!

---

## 7. Intelligent Replanning (Mode 5 Adaptation)

If Mode 5 QA audit reveals a major architectural requirement:
- Antigravity dynamically **inserts, splits, or merges DAG nodes** in `dependency_graph.md`.
- Re-calculates `critical_path.md` without invalidating existing `COMPLETE` nodes.

---

## 8. Dual Execution Modes Overview

| Mode | Name | Best Used For | Execution Pattern |
| :--- | :--- | :--- | :--- |
| **Mode 4** | **Pre-Planned Multi-Step Loop** | Predictable CRUD features | Executes `READY` tasks along the critical path via live bridge. |
| **Mode 5** | **Self-Correcting Quality Loop** | Complex algorithms, refactoring | Dynamic DAG node generation & Planner ➔ Executor ➔ Reviewer loop. |

---

## 9. Atomic State Write Protocol & Crash Recovery

1. **Atomic Writes:** State updates (`project_state.md`, `dependency_graph.md`, `scheduler_state.md`) are written **only AFTER verification passes 100%**.
2. **Crash Recovery:** Saying **"Resume project using MULTI_AGENT_WORKFLOW.md"** reads `scheduler_state.md` and `project_state.md`, auto-recovering from the exact last verified DAG state!

---

## 10. Global Quick-Start Guide for Any Project Repository

To run a project with DAG dependency scheduling:
1. **Launch Desktop Bridge Once Globally:**  
   Open a terminal tab and run:  
   `cd "C:\Users\HP LAPTOP 15s\.gemini\antigravity-ide\scratch"; .\gui_bridge.ps1`
2. **Instruct Antigravity in Any Workspace:**  
   **"Follow MULTI_AGENT_WORKFLOW.md in Mode 5 to build [PROJECT_GOAL]."**
3. **DAG & Critical Path Execution:**  
   Antigravity generates `dependency_graph.md` and `critical_path.md`. Upon approval, Antigravity schedules `READY` tasks, updates the scheduler state, and pops up live streaming terminal windows automatically!
