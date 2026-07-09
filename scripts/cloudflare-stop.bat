@echo off
echo Stopping Cloudflare Tunnel...

tasklist /FI "IMAGENAME eq cloudflared.exe" 2>NUL | findstr /I "cloudflared.exe" >NUL
if errorlevel 1 (
    echo No Cloudflare Tunnel process found.
    exit /b 0
)

taskkill /IM cloudflared.exe /F >NUL
if errorlevel 1 (
    echo Failed to stop Cloudflare Tunnel. Try closing it manually from Task Manager.
    exit /b 1
) else (
    echo Cloudflare Tunnel stopped.
)
