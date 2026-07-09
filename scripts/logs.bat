@echo off
setlocal enabledelayedexpansion
cd /d "C:\Users\wjdgh\IdeaProjects\Company_Project"

if "%~1"=="app" goto :app
if "%~1"=="access" goto :access

echo Which log do you want to see?
echo   1. App log (full Spring Boot console output - startup, errors, SQL, etc.)
echo   2. Tomcat access log (per-request IP, path, status code)
echo.
set /p choice="Choose (1 or 2): "
if "%choice%"=="1" goto :app
if "%choice%"=="2" goto :access
echo Invalid choice. You can also run scripts\logs.bat [app^|access] directly.
exit /b 1

:app
if not exist "logs\app.log" (
    echo logs\app.log not found yet. Start the app first with scripts\start.bat.
    exit /b 1
)
echo Tailing logs\app.log ... (Ctrl+C to stop)
echo.
powershell -NoProfile -Command "Get-Content -Path 'logs\app.log' -Wait -Tail 50"
goto :eof

:access
powershell -NoProfile -Command "$f = Get-ChildItem 'logs\access_log.*.log' -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1; if (-not $f) { Write-Output 'No logs\access_log.*.log file yet. Start the app, send a request, then try again.'; exit 1 }; Write-Output ('Tailing {0} ... (Ctrl+C to stop)' -f $f.FullName); Get-Content -Path $f.FullName -Wait -Tail 50"
goto :eof
