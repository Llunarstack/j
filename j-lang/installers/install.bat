@echo off
REM J Language - Windows Installer Launcher
REM This batch file runs the PowerShell installer and keeps the window open

echo.
echo ================================================
echo   J Language Installer
echo ================================================
echo.

REM Run PowerShell installer
powershell.exe -ExecutionPolicy Bypass -File "%~dp0install.ps1"

REM Keep window open
echo.
echo.
pause
