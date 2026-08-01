# Standard Operating Procedure: Multi-Agent Software Development Workflow

**Document Version:** 2.3.0  
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

## 3. The 7-Step Iterative Workflow Loop

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

## 4. Rules for Task Decomposition

To maximize execution agent success:
1. **Atomic & Scoped:** Each task must focus on a single module, class, or decoupled feature set.
2. **Explicit Interfaces:** Prompts must explicitly state function signatures, input/output types, error handling expectations, and file paths.
3. **Mandatory Test Requirement:** Every task prompt assigned to an execution agent must mandate creating corresponding unit test files.
4. **Self-Contained Context:** Always specify exact file paths and expected behaviors.

---

## 5. Standard CLI Prompting Format for OpenCode

When Antigravity posts tasks for OpenCode, the invocation string follows this structured template:

```powershell
opencode run --auto -m opencode/deepseek-v4-flash-free --print-logs `
"Task ID: [TASK_ID]
Context: [BRIEF ARCHITECTURAL CONTEXT]
Requirements:
1. Create/Modify file: [FILE_PATH]
   - Implement function/class: [SIGNATURE]
   - Docstrings & type hints required.
2. Create/Modify test file: [TEST_FILE_PATH]
   - Write comprehensive unit tests covering edge cases.
3. Verify that all unit tests pass before exiting."
```

---

## 6. Rules for Verification Before Reporting Completion

Antigravity **must never declare a task completed** until the following empirical checks pass:
1. **File Existence Check:** Confirm target source files and test files exist in the expected workspace directory.
2. **Automated Test Suite Execution:** Execute test runners (`python -m unittest`, `pytest`, `npm test`, etc.) via terminal and verify 100% exit code 0 success.
3. **Static Analysis & Code Review:** Inspect generated code for proper docstrings, type annotations, and absence of dummy fallbacks.

---

## 7. Definition of Done (DoD)

A task is considered **DONE** if and only if:
- [ ] Source files exist in the specified project directory.
- [ ] Accompanying unit test files exist.
- [ ] Unit tests pass with 0 failures and 0 errors.
- [ ] Code adheres to type safety and documentation standards.
- [ ] Antigravity has performed visual/diff code inspection.
- [ ] Walkthrough documentation (`walkthrough.md`) has been updated.

---

## 8. Error Handling & Recovery Process

If an execution agent fails or generates broken code:
1. **Log Inspection:** Antigravity reads stdout/stderr and error tracebacks.
2. **Root Cause Analysis:** Determine whether failure was due to prompt constraints, model selection, or environment issues.
3. **Targeted Remediation:** Antigravity re-invokes the execution agent with a targeted bug-fix prompt containing the exact error log.
4. **Model Fallback:** If the execution agent hangs or fails repeatedly, switch the model flag (`-m`) to a higher-capability tier.

---

## 9. Guidelines for Token Minimization

To preserve Antigravity's context window and minimize costs across long sessions:
- **Delegate Code Generation:** Antigravity must never generate massive multi-file code blocks directly in its chat context when an execution agent can do it.
- **Compact Log Summaries:** Antigravity should parse tool outputs silently and summarize only key findings to the user.
- **Isolated Execution History:** Raw LLM generation loops stay inside OpenCode's isolated CLI session.

---

## 10. Future Extensibility (Swap-and-Play Execution Agents)

This workflow is agnostic to the underlying CLI tool:
- **OpenCode:** `opencode run --auto -m <model> "prompt"`
- **Claude Code CLI:** `claude -p "prompt"`
- **Codex / Gemini CLI:** `<agent_cli> run "prompt"`

---

## 11. Global Quick-Start Guide for Any Project Repository

To use this workflow in any new conversation or workspace:
1. **Launch Desktop Bridge Once Globally:**  
   Open a terminal tab and run:  
   `cd "C:\Users\HP LAPTOP 15s\.gemini\antigravity-ide\scratch"; .\gui_bridge.ps1`
2. **Instruct Antigravity in Any New Chat:**  
   **"Follow MULTI_AGENT_WORKFLOW.md in Autonomous Mode to build [YOUR_PROJECT_GOAL]."**
3. **Automatic Directory Handling:**  
   Antigravity automatically detects your current active workspace project path (CWD) and passes it in the bridge task payload. The pop-up window automatically `cd`s to your target project folder!

---

## 12. Autonomous Multi-Agent Iteration Loop Protocol

When running in **Autonomous Mode**, Antigravity executes sequential iterations without stopping until the milestone satisfies the Definition of Done:

1. **Desktop GUI Bridge Event Post:**  
   Antigravity posts the prompt for Iteration $N$ (tagged with iteration index `[ITERATION N]`) to the central Desktop Bridge queue.
2. **Live Visual Pop-Up Window with Window Title Indicator:**  
   `gui_bridge.ps1` detects the task and automatically spawns a visible PowerShell window titled:  
   `ANTIGRAVITY LIVE STREAM [ITERATION N] - [TASK_TITLE]`  
   running:  
   `opencode run --auto -m opencode/deepseek-v4-flash-free --print-logs "<ANTIGRAVITY_PROMPT>"`  
   The user watches OpenCode stream its reasoning and code creation live on screen.
3. **Automated Detection & Verification:**  
   As soon as OpenCode completes the task and exits the window, Antigravity automatically detects the new/modified files and runs `pytest`/test runner verification.
4. **Continuous Advancement Loop:**  
   - If tests pass 100%: Antigravity records Iteration $N$ success, posts Iteration $N+1$ to the Desktop Bridge queue, and a new pop-up window opens automatically for the next task!
   - If tests fail: Antigravity captures the error traceback, posts a repair task to the bridge queue, and OpenCode re-runs to fix the bug.
5. **Safety Circuit Breaker:** Max 5 autonomous iterations per milestone.
