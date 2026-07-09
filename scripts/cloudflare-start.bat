@echo off
setlocal enabledelayedexpansion

tasklist /FI "IMAGENAME eq cloudflared.exe" 2>NUL | findstr /I "cloudflared.exe" >NUL
if not errorlevel 1 (
    echo Cloudflare Tunnel is already running. Run scripts\cloudflare-stop.bat first if you want to restart it.
    exit /b 1
)

netstat -ano | findstr ":8080 " | findstr "LISTENING" >NUL
if errorlevel 1 (
    echo No app is listening on port 8080. Start it first with scripts\start.bat.
    exit /b 1
)

set "CLOUDFLARED_EXE="
where cloudflared >NUL 2>NUL
if not errorlevel 1 (
    set "CLOUDFLARED_EXE=cloudflared"
) else if exist "%ProgramFiles(x86)%\cloudflared\cloudflared.exe" (
    set "CLOUDFLARED_EXE=%ProgramFiles(x86)%\cloudflared\cloudflared.exe"
) else if exist "%ProgramFiles%\cloudflared\cloudflared.exe" (
    set "CLOUDFLARED_EXE=%ProgramFiles%\cloudflared\cloudflared.exe"
)

if not defined CLOUDFLARED_EXE (
    echo cloudflared.exe not found. Install it first: winget install --id Cloudflare.cloudflared
    exit /b 1
)

if not exist "%USERPROFILE%\.cloudflared\config.yml" (
    echo Tunnel config not found at %USERPROFILE%\.cloudflared\config.yml
    echo Run "cloudflared tunnel login", "tunnel create junimusic", and "tunnel route dns junimusic junimusic.shop" first.
    exit /b 1
)

echo Starting Cloudflare Tunnel (junimusic) for http://localhost:8080 ...
echo Site will be reachable at https://junimusic.shop once connected. Keep this window open. Press Ctrl+C to stop.
echo.
"%CLOUDFLARED_EXE%" tunnel run junimusic
