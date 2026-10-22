@echo off
:: 시아쌤 자동 푸시 - 시작프로그램 등록
set SCRIPT_PATH=%~dp0auto_push.ps1
set STARTUP_DIR=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

:: 시작프로그램 폴더에 바로가기 생성
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%TEMP%\create_shortcut.vbs"
echo sLinkFile = "%STARTUP_DIR%\시아쌤_자동푸시.lnk" >> "%TEMP%\create_shortcut.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%TEMP%\create_shortcut.vbs"
echo oLink.TargetPath = "powershell.exe" >> "%TEMP%\create_shortcut.vbs"
echo oLink.Arguments = "-ExecutionPolicy Bypass -WindowStyle Minimized -File ""%SCRIPT_PATH%""" >> "%TEMP%\create_shortcut.vbs"
echo oLink.WorkingDirectory = "%~dp0" >> "%TEMP%\create_shortcut.vbs"
echo oLink.WindowStyle = 7 >> "%TEMP%\create_shortcut.vbs"
echo oLink.Description = "시아쌤 GitHub 자동 푸시" >> "%TEMP%\create_shortcut.vbs"
echo oLink.Save >> "%TEMP%\create_shortcut.vbs"
cscript //nologo "%TEMP%\create_shortcut.vbs"
del "%TEMP%\create_shortcut.vbs"

echo.
echo ✅ 설정 완료! 이제 컴퓨터를 켤 때마다 자동으로 실행돼요.
echo    (창은 최소화된 상태로 백그라운드에서 실행됩니다)
echo.
pause
