@echo off
cd /d "%~dp0"
if not exist "installer.cpp" (
    echo installer.cpp not found!
    pause
    exit /b 1
)

echo Compiling installer...
cl.exe /EHsc /std:c++17 /O2 /Fe:j-installer.exe installer.cpp shell32.lib advapi32.lib user32.lib

if exist "j-installer.exe" (
    echo Build successful: j-installer.exe
) else (
    echo Build failed. Make sure you are in Developer Command Prompt for Visual Studio.
)
pause