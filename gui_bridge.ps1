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

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Clear-Host
$b64Banner = "PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQrilojilojilojilZcgICDilojilojilojilZfilojilojilZcgIOKWiOKWiOKWiOKWiOKWiOKWiOKWiOKWiOKVl+KWiOKWiOKVlwrilojilojilojilojilZcg4paI4paI4paI4paI4pWR4paI4paI4pWRICAg4paI4paI4pWR4paI4paI4pWRICDilZrilZDilZDilojilojilZTilZDilZDilZ3ilojilojilZEK4paI4paI4pWU4paI4paI4paI4paI4pWU4paI4paI4pWR4paI4paI4pWRICAg4paI4paI4pWR4paI4paI4pWRICAgICDilojilojilZEgICDilojilojilZEK4paI4paI4pWR4pWa4paI4paI4pWU4pWd4paI4paI4pWR4paI4paI4pWRICAg4paI4paI4pWR4paI4paI4pWRICAgICDilojilojilZEgICDilojilojilZEK4paI4paI4pWRIOKVmuKVkOKVnSDilojilojilZHilZrilojilojilojilojilojilojilZTilZ3ilojilojilojilojilojilojilojilZfilojilojilZEgICDilojilojilZEK4pWa4pWQ4pWdICAgICDilZrilZDilZ0g4pWa4pWQ4pWQ4pWQ4pWQ4pWQ4pWdIOKVmuKVkOKVkOKVkOKVkOKVkOKVkOKVneKVmuKVkOKVnSAgIOKVmuKVkOKVnQoKIOKWiOKWiOKWiOKWiOKWiOKVlyAg4paI4paI4paI4paI4paI4paI4pWXIOKWiOKWiOKWiOKWiOKWiOKWiOKWiOKVl+KWiOKWiOKWiOKVlyAgIOKWiOKWiOKVl+KWiOKWiOKWiOKWiOKWiOKWiOKWiOKWiOKVlwrilojilojilZTilZDilZDilojilojilZfilojilojilZTilZDilZDilZDilZDilZ0g4paI4paI4pWU4pWQ4pWQ4pWQ4pWQ4pWd4paI4paI4paI4paI4pWXICDilojilojilZHilZrilZDilZDilojilojilZTilZDilZDilZ0K4paI4paI4paI4paI4paI4paI4paI4pWR4paI4paI4pWRICDilojilojilojilZfilojilojilojilojilojilZcgIOKWiOKWiOKVlOKWiOKWiOKVlyDilojilojilZEgICDilojilojilZEK4paI4paI4pWU4pWQ4pWQ4paI4paI4pWR4paI4paI4pWRICAg4paI4paI4pWR4paI4paI4pWU4pWQ4pWQ4pWdICDilojilojilZHilZrilojilojilZfilojilojilZEgICDilojilojilZEK4paI4paI4pWRICDilojilojilZHilZrilojilojilojilojilojilojilZTilZ3ilojilojilojilojilojilojilojilZfilojilojilZEg4pWa4paI4paI4paI4paI4pWRICAg4paI4paI4pWRCuKVmuKVkOKVnSAg4pWa4pWQ4pWdIOKVmuKVkOKVkOKVkOKVkOKVkOKVnSDilZrilZDilZDilZDilZDilZDilZDilZ3ilZrilZDilZ0gIOKVmuKVkOKVkOKVkOKVnSAgIOKVmuKVkOKVnQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0="
$mainBanner = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($b64Banner))

Write-Host $mainBanner -ForegroundColor Cyan
Write-Host "  ANTIGRAVITY LIVE DESKTOP VISUALIZER ACTIVE (SESSION 1)" -ForegroundColor Yellow
Write-Host "  Autonomous Swarm Mode (Dynamic Scaling: 1 to 5 Workers)" -ForegroundColor Cyan
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
                        $workerId = if ($task.worker_id) { $task.worker_id } else { "Worker-1" }
                        $iteration = if ($task.iteration) { $task.iteration } else { "1" }
                        $mode = if ($task.mode) { $task.mode } else { "Mode 5 (Self-Correcting Quality Loop)" }
                        
                        Write-Host "[ANTIGRAVITY ARCHITECT] [$workerId] [ITERATION $iteration] Launching Task: $($task.title)" -ForegroundColor Green
                        
                        $cwd = if ($task.cwd) { $task.cwd } else { "C:\Users\HP LAPTOP 15s\.gemini\antigravity-ide\scratch" }
                        $model = if ($task.model) { $task.model } else { "opencode/deepseek-v4-flash-free" }
                        $promptText = if ($task.prompt) { $task.prompt } else { $task.command }
                        $cleanPrompt = $promptText.Replace('"', '`"').Replace("'", "''")
                        $taskTitle = $task.title
                        
                        if ($task.action -eq "opencode") {
                            $windowTitle = "ANTIGRAVITY LIVE STREAM [$workerId] [ITERATION $iteration] - $taskTitle"
                            
                            $psScript = "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8`n" +
                            "Clear-Host`n" +
                            "`$b64 = '$b64Banner'`n" +
                            "`$banner = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String(`$b64))`n" +
                            "Write-Host `$banner -ForegroundColor Cyan`n" +
                            "Write-Host '  WORKER ID  : $workerId' -ForegroundColor Green`n" +
                            "Write-Host '  ACTIVE MODE: $mode' -ForegroundColor Green`n" +
                            "Write-Host '  CYCLE      : Iteration $iteration' -ForegroundColor Yellow`n" +
                            "Write-Host '  TASK TARGET: $taskTitle' -ForegroundColor Yellow`n" +
                            "Write-Host '==========================================================' -ForegroundColor Cyan`n" +
                            "Write-Host ''`n" +
                            "`$host.UI.RawUI.WindowTitle = '$windowTitle'`n" +
                            "Set-Location -LiteralPath '$cwd'`n" +
                            "opencode run --auto -m $model --print-logs '$cleanPrompt'"
                            
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
