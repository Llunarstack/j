@echo off
REM Build J Language Installer with Visual Studio

echo.
echo ==================================================
echo   Building J Language Installer
echo ==================================================
echo.

REM Check for Visual Studio
where cl.exe >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Visual Studio compiler not found in PATH
    echo.
    echo Please run this from "Developer Command Prompt for VS"
    echo Or run: "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat"
    echo.
    pause
    exit /b 1
)

echo Compiling installer.cpp...
echo.

REM Compile with Visual Studio
cl.exe /EHsc /std:c++17 /O2 /Fe:j-installer.exe installer.cpp ^
    shell32.lib advapi32.lib user32.lib

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ==================================================
    echo   Build Successful!
    echo ==================================================
    echo.
    echo Output: j-installer.exe
    echo Size: 
    dir j-installer.exe | find "j-installer.exe"
    echo.
    echo To install J, run: j-installer.exe
    echo.
) else (
    echo.
    echo ==================================================
    echo   Build Failed!
    echo ==================================================
    echo.
)

REM Clean up intermediate files
del installer.obj 2>nul

pause
