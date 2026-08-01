# 🚀 Multi-Agent Orchestration Kit (Antigravity + OpenCode)

An open-source standard operating procedure, protocol manual, and Desktop GUI Bridge for multi-agent autonomous software development pairing **Antigravity (Lead Architect & QA Orchestrator)** with **OpenCode (CLI Execution Worker)**.

---

## 💡 What is Multi-Agent Orchestration?

Modern AI software development requires clear separation of concerns:
- **Antigravity (Lead Architect & QA Manager):** Handles high-level reasoning, system design, requirements analysis, task decomposition, and unit test verification. Maintains a clean, lean context window.
- **OpenCode (Execution Worker):** Spawns headlessly in a CLI subprocess to execute code generation, file edits, and inline refactoring using fast models like `opencode/deepseek-v4-flash-free`.
- **Developer (Product Owner):** Watches live code generation in streaming pop-up terminals and directs project milestones.

---

## 📋 Prerequisites

1. **Node.js** (v18+)
2. **Python** (v3.10+) with `pytest` installed (`pip install pytest`)
3. **OpenCode CLI** installed and authenticated (`opencode --version`)
4. **Windows 10/11** PowerShell environment

---

## 🛠️ Step-by-Step Setup & Setup Guide

### Step 1: Open the Kit in Antigravity IDE
In Antigravity IDE, go to **File ➔ Open Folder...** and select:
`C:\Users\HP LAPTOP 15s\multi-agent-orchestration-kit`

### Step 2: Start the Desktop GUI Visualizer Bridge (Once Per Session)
Open a terminal tab and run:
```powershell
cd "C:\Users\HP LAPTOP 15s\multi-agent-orchestration-kit"
.\gui_bridge.ps1
```
> **What this does:** Spawns a background listener in your interactive session. Whenever Antigravity delegates a task, a visible PowerShell window pops up streaming OpenCode's reasoning and code creation live on screen!

### Step 3: Trigger Autonomous Multi-Agent Execution
In any new chat or workspace, reference `MULTI_AGENT_WORKFLOW.md`:
> **"Follow MULTI_AGENT_WORKFLOW.md in Autonomous Mode to build [YOUR_PROJECT_GOAL]."**

---

## 🔄 The Autonomous 7-Step Iterative Loop

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
| 3. Task Decomposition (Antigravity prepares atomic task prompts)                  |
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
| 6. QA & Verification (Antigravity runs pytest, inspects diffs, verifies DoD)       |
+-----------------------------------------+-----------------------------------------+
                                          |
                                          v
+-----------------------------------------------------------------------------------+
| 7. Continuous Advancement (Antigravity posts Iteration N+1 until project is done)  |
+-----------------------------------------------------------------------------------+
```

---

## 📁 Repository File Structure

| File | Description |
| :--- | :--- |
| **`MULTI_AGENT_WORKFLOW.md`** | Version 2.3.0 Standard Operating Procedure & Protocol Manual. |
| **`gui_bridge.ps1`** | Windows Session 1 Desktop GUI Bridge (Single-window deduplication, RAM protection, and Window Title `[ITERATION X]` tagging). |
| **`post_gui_request.js`** | Event queue helper script for posting task prompts. |
| **`README.md`** | Setup & Installation Guide. |

---

## 🌐 How to Push to GitHub / GitLab

To publish this kit to your personal GitHub account:

1. Create a new empty repository on [GitHub](https://github.com/new) named `multi-agent-orchestration-kit`.
2. Open PowerShell in `C:\Users\HP LAPTOP 15s\multi-agent-orchestration-kit` and run:
   ```powershell
   git remote add origin https://github.com/YOUR_GITHUB_USERNAME/multi-agent-orchestration-kit.git
   git branch -M main
   git push -u origin main
   ```
