@echo off
echo Stopping server on port 8080...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080 " ^| findstr "LISTENING"') do (
    taskkill /PID %%a /F
    echo Done. PID %%a terminated.
    goto :done
)
echo No server running on port 8080.
:done