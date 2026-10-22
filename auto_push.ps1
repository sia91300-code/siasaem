# 시아쌤 GitHub 자동 푸시 스크립트
# 파일 변경 감지하면 자동으로 커밋 + 푸시

$repoPath = "C:\Users\user\Documents\GitHub\siasaem"

Write-Host "👀 시아쌤 사이트 감시 시작..." -ForegroundColor Cyan

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $repoPath
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true
$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite

$action = {
    Start-Sleep -Seconds 3  # 여러 파일 동시 저장 대기
    Set-Location $repoPath
    $status = git status --porcelain
    if ($status) {
        git add .
        git commit -m "자동 업데이트 $(Get-Date -Format 'MM/dd HH:mm')"
        git push
        Write-Host "✅ 자동 푸시 완료! $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor Green
    }
}

Register-ObjectEvent $watcher "Changed" -Action $action | Out-Null
Register-ObjectEvent $watcher "Created" -Action $action | Out-Null

Write-Host "✅ 감시 중... 파일이 바뀌면 자동으로 GitHub에 올라가요!" -ForegroundColor Green
Write-Host "종료하려면 Ctrl+C 를 누르세요." -ForegroundColor Yellow

while ($true) { Start-Sleep -Seconds 1 }
