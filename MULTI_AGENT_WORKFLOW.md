# Standard Operating Procedure: Multi-Agent Software Development Workflow

**Document Version:** 8.0.0 (True Parallel Multi-Worker Orchestration Edition)  
**Target Agents:** Antigravity (Lead Architect & Parallel Worker Pool Manager) & OpenCode / CLI Execution Agents  
**Scope:** Reusable engineering manual for multi-agent software development across any project repository.

---

## 1. Purpose & Philosophy

Modern AI-assisted software development requires clear separation of concerns. Running a single LLM to simultaneously handle high-level architectural planning, file system edits, token-heavy code generation, and iterative debugging leads to context bloat, degraded reasoning, and unnecessary API token costs.

This **Multi-Agent Workflow** decouples high-level reasoning from low-level code generation:
- **Antigravity** acts as the high-level **Chief Architect, Parallel Worker Pool Manager, and QA Orchestrator**, managing DAG dependency graphs, dispatching concurrent OpenCode workers, enforcing synchronization barriers, and verifying merge quality.
- **CLI Execution Workers (`Worker-1`, `Worker-2`, `Worker-3`)** act as specialized **Execution Agents**, performing localized file modifications, heavy code generation, and fast refactoring in isolated CLI subprocesses streaming live on screen.
- **The User** acts as the **Product Owner & Director**, approving architectural plans and reviewing incremental milestone deliverables.

---

## 2. Roles & Responsibilities

| Role | Agent / Entity | Core Responsibilities |
| :--- | :--- | :--- |
| **Product Owner** | **User** | Defines project goals, approves milestone plans, monitors parallel worker streaming windows, and accepts final deliverables. |
| **Parallel Pool Manager & Architect** | **Antigravity** | Detects worker capability, manages `worker_pool.md`, dispatches `READY` tasks to idle workers, enforces synchronization barriers, resolves conflicts, and manages state transitions. |
| **Parallel Execution Workers** | **OpenCode CLI Workers** (`Worker-1` to `Worker-3`) | Execute assigned independent task nodes concurrently in live streaming pop-up windows. |

---

## 3. Worker Pool Architecture (`worker_pool.md`) 🏊‍♂️

Antigravity maintains an active pool of up to 3 independent execution workers:

```
                            DAG SCHEDULER
                                 │
         ┌───────────────────────┼───────────────────────┐
         ▼                       ▼                       ▼
     WORKER-1                WORKER-2                WORKER-3
(Frontend Module)       (Backend API)           (Documentation)
         │                       │                       │
         ▼                       ▼                       ▼
  Live Window 1           Live Window 2           Live Window 3
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                                 ▼
                     SYNCHRONIZATION BARRIER
                                 │
                                 ▼
                         MERGE & QA GATE
```

### Worker Status State Machine:
- **`IDLE`:** Worker available for task assignment.
- **`RUNNING`:** Worker executing task in a live streaming pop-up window.
- **`WAITING`:** Worker finished task; waiting at synchronization barrier.
- **`FAILED`:** Worker execution failed; flagged for isolated rescheduling.
- **`COMPLETE`:** Worker output verified 100% by Antigravity.

---

## 4. Worker Capability Detection & Graceful Fallback 🛡️

Before dispatching tasks, Antigravity executes the **Capability Detection Protocol**:
1. **Detect Available Concurrency:**  
   - 3 Workers available ➔ Launch 3 parallel workers (`Worker-1`, `Worker-2`, `Worker-3`).
   - 2 Workers available ➔ Launch 2 parallel workers (`Worker-1`, `Worker-2`).
   - 1 Worker available ➔ **Gracefully fall back to sequential execution**.
2. **Prevent Resource Contention:** Hard cap of Max 3 concurrent execution processes.

---

## 5. Parallel Desktop GUI Streaming 🖥️

Every parallel worker launches its own visible PowerShell terminal window with custom title bar labeling:
- Window 1: `ANTIGRAVITY LIVE STREAM [WORKER-1] [CYCLE 1] - Frontend Module`
- Window 2: `ANTIGRAVITY LIVE STREAM [WORKER-2] [CYCLE 1] - Backend API`
- Window 3: `ANTIGRAVITY LIVE STREAM [WORKER-3] [CYCLE 1] - Documentation`

The developer can watch all active workers streaming code creation live on screen simultaneously!

---

## 6. Synchronization Barrier & Merge Gate Protocol 🛑

Antigravity enforces a strict **Synchronization Barrier** before advancing to downstream dependent tasks:

1. **Barrier Hold:** Antigravity pauses execution until ALL dispatched parallel workers exit their windows.
2. **Merge & Conflict Audit:** Antigravity inspects generated files across workers:
   - Detects file/API signature conflicts.
   - Executes Pytest test suites across all modules.
   - Verifies zero regression or duplicate implementations.
3. **Barrier Release:** If 100% passed, unblocks dependent `BLOCKED` tasks in the DAG graph.

---

## 7. Smart Partial Rescheduling

If `Worker-2` fails during a parallel cycle while `Worker-1` and `Worker-3` succeed:
- Antigravity **does NOT restart the entire milestone**.
- Antigravity isolates `Worker-2`, generates a targeted repair prompt, and launches **only `Worker-2`**, keeping completed work from `Worker-1` and `Worker-3` intact!

---

## 8. Scheduler & State File Map 📊

```
Project/
├── MULTI_AGENT_WORKFLOW.md      (Protocol Manual v8.0.0)
├── project_state.md             (Single Source of Truth Index)
├── worker_pool.md               (Worker states: IDLE, RUNNING, COMPLETE)
├── scheduler_dashboard.md       (Live multi-worker status dashboard)
├── dependency_graph.md          (DAG Task Node Map & relationships)
├── critical_path.md             (Critical Path Analysis)
├── scheduler_state.md           (Queue status: BLOCKED, READY, RUNNING, COMPLETE)
├── scheduler_log.md             (Chronological dispatch log)
├── implementation_plan.md       (Active milestone task roadmap)
├── architecture_decisions.md    (Cross-milestone ADR memory)
├── iteration_history.json       (Machine-readable audit trail)
├── walkthrough.md               (Human-readable progress log)
└── project_retrospective.md     (Final project retrospective summary)
```

---

## 9. Dual Execution Modes (Mode 4 & Mode 5) Preserved

Version 8 fully preserves both operating modes:
- **Mode 4 (Pre-Planned Multi-Step Loop):** Parallel workers execute pre-planned `READY` DAG nodes simultaneously.
- **Mode 5 (Self-Correcting Quality Loop):** Parallel workers execute dynamic self-correction and refactoring tasks concurrently.

---

## 10. Global Quick-Start & Auto-Resume Guide

To run a project with True Parallel Multi-Worker Orchestration:
1. **Launch Desktop Bridge Once Globally:**  
   Open a terminal tab and run:  
   `cd "C:\Users\HP LAPTOP 15s\.gemini\antigravity-ide\scratch"; .\gui_bridge.ps1`
2. **Instruct Antigravity in Any Workspace:**  
   **"Follow MULTI_AGENT_WORKFLOW.md in Mode 5 to build [PROJECT_GOAL]."**
3. **Automatic Parallel Dispatch & Resume:**  
   Antigravity analyzes DAG dependencies, detects worker capability, dispatches tasks to `Worker-1`, `Worker-2`, `Worker-3` concurrently, streams live windows on screen, and enforces synchronization barriers automatically!
