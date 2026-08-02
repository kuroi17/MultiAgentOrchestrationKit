# Standard Operating Procedure: Multi-Agent Software Development Workflow

**Document Version:** 10.0.0 (Adaptive Collaborative Swarm Edition)  
**Target Agents:** Antigravity (Autonomous Chief Architect, Traffic Controller & Swarm Manager) & OpenCode / CLI Execution Agents  
**Scope:** Reusable engineering manual for multi-agent software development across any project repository.

---

## 1. Purpose & Philosophy

Modern AI-assisted software development requires clear separation of concerns. Running a single LLM to simultaneously handle high-level architectural planning, file system edits, token-heavy code generation, and iterative debugging leads to context bloat, degraded reasoning, and unnecessary API token costs.

Version 10.0.0 evolves the Multi-Agent Workflow from parallel execution into **Adaptive Collaborative Swarm Intelligence**:
- **Antigravity** acts as the high-level **Chief Architect, Adaptive Decision Engine, Swarm Traffic Controller, and Message Broker**, automatically evaluating whether work requires **Sequential**, **Parallel Swarm**, or **Collaborative Swarm** execution, mediating all inter-worker communication via `swarm_blackboard.md`.
- **CLI Execution Workers (`Worker-1` to `Worker-5`)** act as specialized **Execution Agents**, performing localized file modifications, heavy code generation, and fast refactoring in isolated CLI subprocesses.
- **The User** acts as the **Product Owner & Director**, approving architectural plans and watching live streaming parallel pop-up terminals alongside the **7th Live Swarm Blackboard Window**.

---

## 2. Roles & Responsibilities

| Role | Agent / Entity | Core Responsibilities |
| :--- | :--- | :--- |
| **Product Owner** | **User** | Defines project goals, approves milestone plans, monitors parallel worker streaming windows, and accepts final deliverables. Optional manual override for Mode & Swarm selection. |
| **Adaptive Swarm Controller & Architect** | **Antigravity** | Auto-evaluates coupling & DAG graph to select Sequential, Parallel, or Collaborative Swarm. Mediates all messages through `swarm_blackboard.md`. Enforces 7-Window streaming and synchronization barriers. |
| **Parallel Execution Workers** | **OpenCode CLI Workers** (`Worker-1` to `Worker-5`) | Execute assigned independent or collaborative task nodes concurrently. Publish requests to Swarm Blackboard. Bypassing Antigravity or direct worker messaging is strictly prohibited. |

---

## 3. Adaptive Swarm Decision Engine 🧠

Antigravity automatically evaluates project tasks before dispatch to select the optimal Swarm Mode:

```
                            PROJECT MILESTONE
                                    │
                                    ▼
                     [ADAPTIVE SWARM DECISION ENGINE]
                     ┌──────────────┼──────────────┐
                     ▼              ▼              ▼
                SEQUENTIAL     PARALLEL SWARM  COLLABORATIVE SWARM
             (Dependent DAG)  (Independent)   (Shared Schema/API)
```

### Auto-Selection Criteria:
1. **Sequential Mode:** Selected for tightly coupled single-threaded task chains ($T_1 \rightarrow T_2 \rightarrow T_3$).
2. **Parallel Swarm Mode:** Auto-selected when tasks are completely independent (e.g. isolated utility modules, docs, separate frontend/backend files).
3. **Collaborative Swarm Mode:** Auto-selected when tasks share API contracts, database schemas, protocol definitions, or cross-component integration interfaces.
4. **Manual Developer Override:** The user can command *"Force Sequential"*, *"Force Parallel Swarm"*, or *"Force Collaborative Swarm"*.

---

## 4. Swarm Blackboard & Centralized Mediated Communication Protocol 🛰️

Centralized hub: `swarm_blackboard.md`  
Audit log: `swarm_log.md`

### Communication Architecture:
```
Worker-1 ──┐
Worker-2 ──┤
Worker-3 ──┼──> Swarm Blackboard (swarm_blackboard.md) ──> Antigravity (Mediator)
Worker-4 ──┤
Worker-5 ──┘
```

### Core Communication Rules:
1. **Strict Mediation:** Workers MUST NEVER directly edit another worker's files or message another worker directly.
2. **Structured Message Payloads:** Workers publish message objects (`REQUEST`, `DISCOVERY`, `API_CONTRACT`, `SCHEMA_PROPOSAL`, `WARNING`, `BLOCKER`) via `post_gui_request.js blackboard`.
3. **Antigravity Mediation:** Antigravity inspects requests, classifies urgency, approves/resolves schema proposals, and broadcasts updates to target workers.

---

## 5. Seven Window Desktop GUI Streaming Architecture 🖥️

Version 10.0.0 establishes a **7-Window Live Visualization Architecture**:

```
[Window 1]: GUI Bridge Controller (Session 1 Main Window)
[Window 2]: Worker-1 Stream Window
[Window 3]: Worker-2 Stream Window
[Window 4]: Worker-3 Stream Window
[Window 5]: Worker-4 Stream Window
[Window 6]: Worker-5 Stream Window
[Window 7]: ANTIGRAVITY SWARM BLACKBOARD (Live Mediated Message Stream)
```

The 7th window continuously streams worker communications, schema proposals, routing decisions, and barrier synchronization events live on screen in full color!

---

## 6. Synchronization Barrier & Merge Gate Protocol 🛑

Before unblocking downstream tasks or merging code:
1. **Blackboard Drain Check:** Verify all outstanding worker questions, API contracts, and schema proposals in `swarm_blackboard.md` are resolved (`COMPLETED`).
2. **Barrier Hold:** Pause execution until all 5 workers complete.
3. **Automated Test Suite Audit:** Execute full `pytest` regression suite across all components.
4. **Merge Gate Release:** Unblock downstream milestones upon 100% test pass.

---

## 7. State File Map (Single Source of Truth) 📊

```
Project/
├── MULTI_AGENT_WORKFLOW.md      (Protocol Manual v10.0.0)
├── project_state.md             (Single Source of Truth Index + Swarm Status)
├── swarm_blackboard.md          (Centralized Communication Hub)
├── swarm_log.md                 (Chronological Communication Audit Log)
├── worker_pool.md               (Worker states: IDLE, RUNNING, COMPLETE)
├── scheduler_dashboard.md       (Live multi-worker status dashboard)
├── dependency_graph.md          (DAG Task Node Map & relationships)
├── critical_path.md             (Critical Path Analysis)
├── architecture_decisions.md    (Cross-milestone ADR memory)
├── iteration_history.json       (Machine-readable audit trail)
├── walkthrough.md               (Human-readable progress log)
└── project_retrospective.md     (Final project retrospective summary)
```

---

## 8. Global Quick-Start Guide

To execute a project using Version 10.0.0:
1. **Launch Desktop Bridge Once Globally:**  
   Open a terminal tab and run:  
   `cd "C:\Users\HP LAPTOP 15s\.gemini\antigravity-ide\scratch"; .\gui_bridge.ps1`
2. **Instruct Antigravity in Any Workspace:**  
   - **Autonomous Mode:** **"Follow MULTI_AGENT_WORKFLOW.md to build [PROJECT_GOAL]."**  
   - **Explicit Collaborative Swarm:** **"Follow MULTI_AGENT_WORKFLOW.md in Collaborative Swarm Mode to build [PROJECT_GOAL]."**
3. **Observe 7 Streaming Windows Live:**  
   Watch 5 workers and the live **Swarm Blackboard Stream** coordinate code creation live on screen!
