@echo off
REM Build J Language Installer - Auto-detect Visual Studio

echo.
echo ==================================================
echo   Building J Language Installer
echo ==================================================
echo.

REM Try to find and run Visual Studio Developer Command Prompt setup
set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"

if exist "%VSWHERE%" (
    echo Detecting Visual Studio installation...
    for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do (
        set "VSINSTALLDIR=%%i"
    )
)

if defined VSINSTALLDIR (
    echo Found Visual Studio at: %VSINSTALLDIR%
    echo Setting up environment...
    call "%VSINSTALLDIR%\Common7\Tools\VsDevCmd.bat"
    echo.
) else (
    REM Try common Visual Studio paths
    if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" (
        echo Found Visual Studio 2022 Community
        call "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat"
    ) else if exist "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat" (
        echo Found Visual Studio 2022 Professional
        call "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat"
    ) else if exist "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\Tools\VsDevCmd.bat" (
        echo Found Visual Studio 2022 Enterprise
        call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\Tools\VsDevCmd.bat"
    ) else if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\VsDevCmd.bat" (
        echo Found Visual Studio 2019 Community
        call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\VsDevCmd.bat"
    ) else (
        echo.
        echo ERROR: Visual Studio not found!
        echo.
        echo Please install Visual Studio 2019 or later with C++ Desktop Development
        echo Download from: https://visualstudio.microsoft.com/downloads/
        echo.
        echo Or run this script from "Developer Command Prompt for VS"
        echo.
        pause
        exit /b 1
    )
)

REM Check if compiler is now available
where cl.exe >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Visual Studio C++ compiler not found!
    echo.
    echo Please install "Desktop development with C++" workload
    echo.
    pause
    exit /b 1
)

echo.
echo Compiling installer.cpp...
echo.

REM Compile
cl.exe /EHsc /std:c++17 /O2 /Fe:j-installer.exe installer.cpp ^
    shell32.lib advapi32.lib user32.lib

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ==================================================
    echo   Build Successful!
    echo ==================================================
    echo.
    echo Output: j-installer.exe
    for %%A in (j-installer.exe) do echo Size: %%~zA bytes
    echo.
    echo To install J, run: j-installer.exe
    echo.
    
    REM Clean up intermediate files
    del installer.obj 2>nul
    
    echo Press any key to run the installer now, or close this window to exit.
    pause >nul
    
    echo.
    echo Running installer...
    echo.
    j-installer.exe
) else (
    echo.
    echo ==================================================
    echo   Build Failed!
    echo ==================================================
    echo.
    echo Check the error messages above.
    echo.
    pause
)
