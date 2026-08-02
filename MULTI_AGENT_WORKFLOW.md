# Standard Operating Procedure: Multi-Agent Software Development Workflow

**Document Version:** 9.0.0 (Autonomous Orchestrator & Dynamic Swarm Edition)  
**Target Agents:** Antigravity (Autonomous Chief Architect, Auto-Mode Classifier & Swarm Manager) & OpenCode / CLI Execution Agents  
**Scope:** Reusable engineering manual for multi-agent software development across any project repository.

---

## 1. Purpose & Philosophy

Modern AI-assisted software development requires clear separation of concerns. Running a single LLM to simultaneously handle high-level architectural planning, file system edits, token-heavy code generation, and iterative debugging leads to context bloat, degraded reasoning, and unnecessary API token costs.

This **Multi-Agent Workflow** decouples high-level reasoning from low-level code generation:
- **Antigravity** acts as the high-level **Chief Architect, Autonomous Classifier, Swarm Manager, and QA Orchestrator**, automatically evaluating task complexity, auto-selecting execution modes, calculating DAG dependencies, and dynamically scaling parallel OpenCode workers.
- **CLI Execution Workers (`Worker-1` to `Worker-5`)** act as specialized **Execution Agents**, performing localized file modifications, heavy code generation, and fast refactoring in isolated CLI subprocesses streaming live on screen.
- **The User** acts as the **Product Owner & Director**, approving architectural plans and watching live streaming parallel pop-up terminals.

---

## 2. Roles & Responsibilities

| Role | Agent / Entity | Core Responsibilities |
| :--- | :--- | :--- |
| **Product Owner** | **User** | Defines project goals, approves milestone plans, monitors parallel worker streaming windows, and accepts final deliverables. Optional manual override for Mode 4 / Mode 5. |
| **Autonomous Swarm Manager & Architect** | **Antigravity** | Auto-evaluates task complexity, auto-assigns Mode 4 vs Mode 5, dynamically scales parallel worker pool (1 to 5 workers based on DAG `READY` tasks), enforces synchronization barriers, resolves conflicts, and manages state transitions. |
| **Parallel Execution Workers** | **OpenCode CLI Workers** (`Worker-1` to `Worker-5`) | Execute assigned independent task nodes concurrently in live streaming pop-up windows. |

---

## 3. Auto-Mode Selection & Complexity Classifier Protocol 🧠

Antigravity automatically evaluates project goals to select the optimal execution mode:

```
                          PROJECT GOAL / TASK
                                   │
                                   ▼
                   [COMPLEXITY & RISK CLASSIFIER]
                   ┌───────────────┴───────────────┐
                   ▼                               ▼
          Low Risk / Rigid CRUD           High Complexity / Refactor
             / Clear Scope                     / Quality Audit Needed
                   │                               │
                   ▼                               ▼
       MODE 4 (Pre-Planned Loop)       MODE 5 (Self-Correcting Quality Loop)
```

### Classification Rules:
1. **Mode 4 (Pre-Planned Multi-Step Loop):**  
   - Auto-selected for standard features, straightforward CRUD modules, and well-defined sequential tasks.
2. **Mode 5 (Self-Correcting Quality Loop):**  
   - Auto-selected for complex algorithms, system refactoring, fuzzy requirements, or security-critical code requiring continuous QA audits.
3. **Manual Developer Override:**  
   - If the user explicitly commands *"Use Mode 4"* or *"Use Mode 5"*, Antigravity **honors the user's manual choice** regardless of auto-classification.

---

## 4. Dynamic Worker Swarm Scaling (1 to 5 Parallel Workers) 🚀

Instead of a hardcoded worker limit, Antigravity **dynamically calculates parallel worker concurrency** based on the number of independent `READY` tasks at the current DAG depth:

```
                            DAG SCHEDULER
                                  │
      ┌──────────────┬────────────┼────────────┬──────────────┐
      ▼              ▼            ▼            ▼              ▼
  WORKER-1       WORKER-2     WORKER-3     WORKER-4       WORKER-5
 (Task Node 1)  (Task Node 2)(Task Node 3)(Task Node 4)  (Task Node 5)
      │              │            │            │              │
      ▼              ▼            ▼            ▼              ▼
 Live Window 1  Live Window 2 Live Window 3 Live Window 4  Live Window 5
      │              │            │            │              │
      └──────────────┴────────────┼────────────┴──────────────┘
                                  │
                                  ▼
                      SYNCHRONIZATION BARRIER
                                  │
                                  ▼
                          MERGE & QA GATE
```

### Concurrency Calculation Protocol:
$$N_{\text{workers}} = \min(5, \text{Count}(\text{READY tasks at current DAG depth}))$$

- **1 `READY` Task:** Launch 1 pop-up window (`Worker-1`).
- **2 `READY` Tasks:** Launch 2 pop-up windows concurrently (`Worker-1`, `Worker-2`).
- **3 `READY` Tasks:** Launch 3 pop-up windows concurrently (`Worker-1`, `Worker-2`, `Worker-3`).
- **4 `READY` Tasks:** Launch 4 pop-up windows concurrently (`Worker-1` to `Worker-4`).
- **5+ `READY` Tasks:** Launch 5 pop-up windows concurrently (`Worker-1` to `Worker-5`).

---

## 5. Parallel Desktop GUI Streaming 🖥️

Every parallel worker launches its own visible PowerShell terminal window with custom title bar labeling and rich dashboard banner:
- Window 1: `ANTIGRAVITY LIVE STREAM [WORKER-1] [MODE 5] [CYCLE 1] - Task Target`
- Window 2: `ANTIGRAVITY LIVE STREAM [WORKER-2] [MODE 5] [CYCLE 1] - Task Target`
- Window 3: `ANTIGRAVITY LIVE STREAM [WORKER-3] [MODE 5] [CYCLE 1] - Task Target`
- Window 4: `ANTIGRAVITY LIVE STREAM [WORKER-4] [MODE 5] [CYCLE 1] - Task Target`
- Window 5: `ANTIGRAVITY LIVE STREAM [WORKER-5] [MODE 5] [CYCLE 1] - Task Target`

The developer can watch up to 5 active workers streaming code creation live on screen simultaneously!

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

If `Worker-2` fails during a parallel cycle while `Worker-1`, `Worker-3`, `Worker-4`, and `Worker-5` succeed:
- Antigravity **does NOT restart the entire milestone**.
- Antigravity isolates `Worker-2`, generates a targeted repair prompt, and launches **only `Worker-2`**, keeping completed work from all other workers intact!

---

## 8. State File Map (Single Source of Truth) 📊

```
Project/
├── MULTI_AGENT_WORKFLOW.md      (Protocol Manual v9.0.0)
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

## 9. Global Quick-Start & Auto-Resume Guide

To run a project with Autonomous Orchestration:
1. **Launch Desktop Bridge Once Globally:**  
   Open a terminal tab and run:  
   `cd "C:\Users\HP LAPTOP 15s\.gemini\antigravity-ide\scratch"; .\gui_bridge.ps1`
2. **Instruct Antigravity in Any Workspace:**  
   - **Fully Autonomous:** **"Follow MULTI_AGENT_WORKFLOW.md to build [PROJECT_GOAL]."**  
     *(Antigravity auto-classifies Mode 4 vs Mode 5 and auto-scales 1 to 5 parallel workers!)*
   - **Manual Mode Override:** **"Follow MULTI_AGENT_WORKFLOW.md using Mode 4 (or Mode 5) to build [PROJECT_GOAL]."**
3. **Automatic Parallel Dispatch & Resume:**  
   Antigravity analyzes DAG dependencies, auto-scales workers up to 5 streaming pop-up windows, and enforces synchronization barriers automatically!
