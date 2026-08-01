const fs = require('fs');
const path = require('path');

const centralBridgeDir = 'C:\\Users\\HP LAPTOP 15s\\.gemini\\antigravity-ide\\scratch\\.gui_bridge';
if (!fs.existsSync(centralBridgeDir)) {
  fs.mkdirSync(centralBridgeDir, { recursive: true });
}

const queueFile = path.join(centralBridgeDir, 'queue.json');
let tasks = [];
if (fs.existsSync(queueFile)) {
  try {
    tasks = JSON.parse(fs.readFileSync(queueFile, 'utf8'));
  } catch (e) {}
}

const action = process.argv[2] || 'opencode';
const title = process.argv[3] || 'Agent Task';
const prompt = process.argv[4] || 'Task prompt instructions...';
const iteration = process.argv[5] || null;
const workerId = process.argv[6] || null;
const targetCwd = process.cwd();

tasks.push({
  id: `gui-task-${tasks.length + 1}`,
  action: action,
  title: title,
  iteration: iteration,
  worker_id: workerId,
  cwd: targetCwd,
  prompt: prompt,
  command: prompt,
  created_at: new Date().toISOString()
});

fs.writeFileSync(queueFile, JSON.stringify(tasks, null, 2));
console.log(`[Antigravity] Posted Task '${title}' (Worker: ${workerId || 'Worker-1'}, Iteration: ${iteration || 1}) for CWD '${targetCwd}'!`);
