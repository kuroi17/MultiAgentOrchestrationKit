# Multi-Agent Orchestration Kit (Antigravity + OpenCode)

An open-source standard operating procedure and Desktop GUI Bridge for multi-agent autonomous software development pairing **Antigravity (Lead Architect & QA Orchestrator)** with **OpenCode (CLI Execution Worker)**.

## 🚀 Quick Start Guide

### 1. Launch the Desktop GUI Visualizer
Run once in any terminal tab:
```powershell
.\gui_bridge.ps1
```

### 2. Instruct Antigravity in Any Workspace
In any new chat conversation, reference `MULTI_AGENT_WORKFLOW.md`:
> *"Follow `MULTI_AGENT_WORKFLOW.md` in Autonomous Mode to build [YOUR_GOAL]."*

---

## 📁 Repository Contents

- `MULTI_AGENT_WORKFLOW.md` – Version 2.3.0 Standard Operating Procedure & Protocol Manual.
- `gui_bridge.ps1` – Windows Session 1 Desktop GUI Bridge (with RAM protection, single-window deduplication, and window title iteration tagging).
- `post_gui_request.js` – CLI helper tool for posting task prompts to the bridge event queue.
