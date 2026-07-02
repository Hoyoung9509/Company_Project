@echo off
echo ?? 8080 ????? ?????...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080 "') do (
    taskkill /PID %%a /F 2>nul
    echo PID %%a ?? ??
    goto :done
)
:done
echo ??
