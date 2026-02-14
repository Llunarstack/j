@echo off
cd /d "%~dp0"
echo ==========================================
echo      J Language - One-Click Setup
echo ==========================================

REM 1. Build binary if it doesn't exist
if not exist "..\target\release\j.exe" (
    echo [1/2] Building J binary (this may take a minute)...
    pushd ..
    cargo build --release
    popd
) else (
    echo [1/2] J binary found.
)

REM 2. Run the PowerShell installer
echo [2/2] Installing...
PowerShell -NoProfile -ExecutionPolicy Bypass -File "install.ps1"

echo.
echo Done! You can now use 'j' in your terminal.
pause