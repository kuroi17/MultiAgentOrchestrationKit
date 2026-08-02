const fs = require('fs');
const path = require('path');

const bridgeDir = path.join(__dirname, '.gui_bridge');
if (!fs.existsSync(bridgeDir)) {
  fs.mkdirSync(bridgeDir, { recursive: true });
}

const queueFile = path.join(bridgeDir, 'queue.json');
const bbQueueFile = path.join(bridgeDir, 'blackboard_queue.json');

const args = process.argv.slice(2);
const action = args[0] || 'opencode';

if (action === 'blackboard') {
  const worker_id = args[1] || 'Worker-1';
  const msg_type = args[2] || 'DISCOVERY';
  const content = args[3] || 'Broadcast message';

  let bbTasks = [];
  if (fs.existsSync(bbQueueFile)) {
    try {
      bbTasks = JSON.parse(fs.readFileSync(bbQueueFile, 'utf8'));
    } catch (e) {
      bbTasks = [];
    }
  }

  const bbPayload = {
    timestamp: new Date().toISOString(),
    worker_id,
    msg_type,
    content
  };

  bbTasks.push(bbPayload);
  fs.writeFileSync(bbQueueFile, JSON.stringify(bbTasks, null, 2), 'utf8');
  console.log(`[Swarm Blackboard] Logged [${worker_id}] [${msg_type}]: ${content}`);
  process.exit(0);
}

const title = args[1] || 'Default Task';
const prompt = args[2] || 'run task';
const iteration = args[3] || '1';
const worker_id = args[4] || 'Worker-1';
const mode = args[5] || 'Mode 5 (Self-Correcting Quality Loop)';
const cwd = process.cwd();

let tasks = [];
if (fs.existsSync(queueFile)) {
  try {
    tasks = JSON.parse(fs.readFileSync(queueFile, 'utf8'));
  } catch (e) {
    tasks = [];
  }
}

const payload = {
  timestamp: new Date().toISOString(),
  action,
  title,
  prompt,
  iteration,
  worker_id,
  mode,
  cwd,
  model: 'opencode/deepseek-v4-flash-free'
};

tasks.push(payload);
fs.writeFileSync(queueFile, JSON.stringify(tasks, null, 2), 'utf8');
console.log(`[Antigravity] Posted Task '${title}' (Worker: ${worker_id}, Iteration: ${iteration}) for CWD '${cwd}'!`);
