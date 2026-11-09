@echo off
chcp 65001 >nul
:: Remove the Siasaem auto push from startup and stop the running watcher
del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\시아쌤_자동푸시.lnk" 2>nul
powershell -NoProfile -Command "Get-CimInstance Win32_Process -Filter \"Name='powershell.exe'\" | Where-Object { $_.CommandLine -like '*auto_push.ps1*' } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force }"
echo.
echo 자동 업로드를 껐어요. 이제 컴퓨터를 켜도 실행되지 않아요.
echo.
pause
