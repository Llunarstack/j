@echo off
echo.
echo J Language - Build Tools Setup
echo ==============================
echo.

echo Checking for Visual Studio Build Tools...

where link.exe >nul 2>&1
if %errorlevel% == 0 (
    echo ✅ Visual Studio Build Tools found!
    goto :test_build
)

echo ❌ Visual Studio Build Tools not found
echo.
echo To enable LLVM compilation, you need Visual Studio Build Tools.
echo.
echo Options:
echo 1. Download Build Tools: https://visualstudio.microsoft.com/visual-cpp-build-tools/
echo 2. Install "C++ build tools" workload
echo 3. Restart your command prompt
echo.
echo For now, you can use J Language in interpreter mode only.
echo.

:test_build
echo Testing J Language build...
cargo build
if %errorlevel% == 0 (
    echo ✅ J Language build successful!
    echo.
    echo You can now use:
    echo   cargo run -- repl          ^(Interactive mode^)
    echo   cargo run -- run file.j    ^(Run J files^)
    echo   cargo run -- check file.j  ^(Check syntax^)
    echo.
    if exist "C:\Program Files (x86)\Microsoft Visual Studio" (
        echo   cargo run -- build file.j   ^(Compile to binary^)
    )
) else (
    echo ❌ Build failed. Please check the error messages above.
)

echo.
echo See README.md for full documentation.
pause