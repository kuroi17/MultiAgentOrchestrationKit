# Launch Swarm Blackboard Window
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$host.UI.RawUI.WindowTitle = 'ANTIGRAVITY SWARM BLACKBOARD (LIVE STREAM)'
Clear-Host

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   A N T I G R A V I T Y   S W A R M   B L A C K B O A R D  " -ForegroundColor Yellow
Write-Host "   Centralized Communication Traffic Controller Hub (v10)   " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

$bbFile = "C:\Users\HP LAPTOP 15s\.gemini\antigravity-ide\scratch\.gui_bridge\blackboard_queue.json"
$lastCount = 0

while ($true) {
    if (Test-Path $bbFile) {
        try {
            $raw = Get-Content $bbFile -Raw -ErrorAction SilentlyContinue
            if ($raw) {
                $items = $raw | ConvertFrom-Json -ErrorAction SilentlyContinue
                if ($items -and $items.Count -gt $lastCount) {
                    for ($j = $lastCount; $j -lt $items.Count; $j++) {
                        $msg = $items[$j]
                        $ts = $msg.timestamp
                        $wId = $msg.worker_id
                        $mType = $msg.msg_type
                        $txt = $msg.content
                        
                        Write-Host "[$ts] [$wId] [$mType]" -ForegroundColor Green -NoNewline
                        Write-Host " -> $txt" -ForegroundColor Yellow
                    }
                    $lastCount = $items.Count
                }
            }
        } catch {}
    }
    Start-Sleep -Milliseconds 500
}
