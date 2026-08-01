# Windows Desktop GUI Bridge for AI Agent Orchestration (Antigravity -> OpenCode Live Visualizer)
param(
    [string]$BridgeDir = "$PSScriptRoot\.gui_bridge"
)

if ([string]::IsNullOrWhiteSpace($PSScriptRoot)) {
    $BridgeDir = "C:\Users\HP LAPTOP 15s\.gemini\antigravity-ide\scratch\.gui_bridge"
}

if (!(Test-Path $BridgeDir)) {
    New-Item -ItemType Directory -Path $BridgeDir -Force | Out-Null
}

$QueueFile = Join-Path $BridgeDir "queue.json"
if (!(Test-Path $QueueFile)) {
    "[]" | Out-File -FilePath $QueueFile -Encoding utf8
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  ANTIGRAVITY LIVE DESKTOP VISUALIZER ACTIVE (SESSION 1)" -ForegroundColor Yellow
Write-Host "  Multi-Worker Parallel Streaming Mode (Max 3 Workers)  " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

# Skip past tasks already in queue on startup
$LastProcessedCount = 0
if (Test-Path $QueueFile) {
    try {
        $existing = Get-Content $QueueFile -Raw | ConvertFrom-Json
        if ($existing) { $LastProcessedCount = $existing.Count }
    } catch {}
}

while ($true) {
    try {
        if (Test-Path $QueueFile) {
            $content = Get-Content $QueueFile -Raw -ErrorAction SilentlyContinue
            if ($content) {
                $tasks = $content | ConvertFrom-Json -ErrorAction SilentlyContinue
                if ($tasks -and $tasks.Count -gt $LastProcessedCount) {
                    for ($i = $LastProcessedCount; $i -lt $tasks.Count; $i++) {
                        $task = $tasks[$i]
                        $workerTag = if ($task.worker_id) { " [$($task.worker_id)]" } else { "" }
                        $iterTag = if ($task.iteration) { " [ITERATION $($task.iteration)]" } else { "" }
                        
                        Write-Host "[ANTIGRAVITY ARCHITECT]$workerTag$iterTag Launching Task: $($task.title)" -ForegroundColor Green
                        
                        $cwd = if ($task.cwd) { $task.cwd } else { "C:\Users\HP LAPTOP 15s\.gemini\antigravity-ide\scratch" }
                        $model = if ($task.model) { $task.model } else { "opencode/deepseek-v4-flash-free" }
                        $promptText = if ($task.prompt) { $task.prompt } else { $task.command }
                        
                        if ($task.action -eq "opencode") {
                            $windowTitle = "ANTIGRAVITY LIVE STREAM$workerTag$iterTag - $($task.title)"
                            $psScript = "`$host.UI.RawUI.WindowTitle = '$windowTitle'`nSet-Location -LiteralPath '$cwd'`nopencode run --auto -m $model --print-logs '$promptText'"
                            $bytes = [System.Text.Encoding]::Unicode.GetBytes($psScript)
                            $encoded = [Convert]::ToBase64String($bytes)
                            
                            Start-Process powershell.exe -ArgumentList "-NoExit", "-EncodedCommand", $encoded
                        } else {
                            Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", "$promptText"
                        }
                    }
                    $LastProcessedCount = $tasks.Count
                }
            }
        }
    } catch {}
    Start-Sleep -Milliseconds 500
}
