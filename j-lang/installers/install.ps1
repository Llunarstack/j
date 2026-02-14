# J Language - Windows Installer
# Simple and reliable installer for Windows

param(
    [switch]$Uninstall = $false,
    [string]$InstallDir = "$env:LOCALAPPDATA\J"
)

$ErrorActionPreference = "Stop"

# Function to pause and exit
function Exit-WithPause {
    param([int]$ExitCode = 0)
    Write-Host ""
    Write-Host "Press any key to exit..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit $ExitCode
}

# Configuration
$BinDir = "$InstallDir\bin"
$ExamplesDir = "$InstallDir\examples"

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  J Programming Language Installer v0.1.0" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Uninstall mode
if ($Uninstall) {
    Write-Host "Uninstalling J..." -ForegroundColor Yellow
    
    if (Test-Path $InstallDir) {
        Remove-Item -Recurse -Force $InstallDir
        Write-Host "Removed: $InstallDir" -ForegroundColor Green
    }
    
    # Remove from PATH
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($userPath -like "*$BinDir*") {
        $newPath = $userPath -replace [regex]::Escape(";$BinDir"), ""
        $newPath = $newPath -replace [regex]::Escape("$BinDir;"), ""
        $newPath = $newPath -replace [regex]::Escape($BinDir), ""
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        Write-Host "Removed from PATH" -ForegroundColor Green
    }
    
    # Remove file association
    Remove-Item -Path "HKCU:\Software\Classes\.j" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCU:\Software\Classes\JSourceFile" -Recurse -Force -ErrorAction SilentlyContinue
    
    Write-Host ""
    Write-Host "J has been uninstalled successfully!" -ForegroundColor Green
    Write-Host "Please restart your terminal." -ForegroundColor Yellow
    Exit-WithPause 0
}

# Detect architecture
$arch = $env:PROCESSOR_ARCHITECTURE
if ($env:PROCESSOR_ARCHITEW6432) {
    $arch = $env:PROCESSOR_ARCHITEW6432
}

$platform = switch ($arch) {
    "AMD64" { "x86_64" }
    "x86" { "i686" }
    "ARM64" { "aarch64" }
    default {
        Write-Host "Unsupported architecture: $arch" -ForegroundColor Red
        exit 1
    }
}

Write-Host "Platform: windows-$platform" -ForegroundColor Cyan
Write-Host "Install directory: $InstallDir" -ForegroundColor Cyan
Write-Host ""

# Find binary
Write-Host "Looking for J executable..." -ForegroundColor Blue

$binaryName = "j-windows-$platform.exe"
$binaryPath = $null

$searchPaths = @(
    "..\dist\$binaryName",
    "dist\$binaryName",
    "..\target\release\j.exe",
    "target\release\j.exe",
    "j.exe"
)

foreach ($path in $searchPaths) {
    if (Test-Path $path) {
        $binaryPath = (Resolve-Path $path).Path
        Write-Host "Found: $path" -ForegroundColor Green
        break
    }
}

if (-not $binaryPath) {
    Write-Host ""
    Write-Host "ERROR: J executable not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please build first:" -ForegroundColor Yellow
    Write-Host "  cd .." -ForegroundColor Blue
    Write-Host "  cargo build --release" -ForegroundColor Blue
    Write-Host ""
    Exit-WithPause 1
}

# Create directories
Write-Host "Creating directories..." -ForegroundColor Blue
New-Item -ItemType Directory -Force -Path $BinDir | Out-Null
New-Item -ItemType Directory -Force -Path $ExamplesDir | Out-Null

# Copy binary
Write-Host "Installing J executable..." -ForegroundColor Blue
Copy-Item $binaryPath "$BinDir\j.exe" -Force
Write-Host "Installed: $BinDir\j.exe" -ForegroundColor Green

# Copy examples
$examplesSrc = if (Test-Path "..\examples") { "..\examples" } else { "examples" }
if (Test-Path $examplesSrc) {
    Write-Host "Copying examples..." -ForegroundColor Blue
    Copy-Item -Path "$examplesSrc\*" -Destination $ExamplesDir -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Copied examples to: $ExamplesDir" -ForegroundColor Green
}

# Copy icon
$iconSrc = if (Test-Path "..\J_lang_logo.ico") { "..\J_lang_logo.ico" } else { "J_lang_logo.ico" }
if (Test-Path $iconSrc) {
    Copy-Item $iconSrc "$InstallDir\J_lang_logo.ico" -Force
}

# Add to PATH
Write-Host "Adding to PATH..." -ForegroundColor Blue
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($userPath -like "*$BinDir*") {
    Write-Host "Already in PATH" -ForegroundColor Yellow
} else {
    if ($userPath) {
        $newPath = "$userPath;$BinDir"
    } else {
        $newPath = $BinDir
    }
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    $env:Path = "$env:Path;$BinDir"
    Write-Host "Added to PATH" -ForegroundColor Green
}

# Create file association
Write-Host "Creating file association..." -ForegroundColor Blue
try {
    New-Item -Path "HKCU:\Software\Classes\.j" -Force | Out-Null
    Set-ItemProperty -Path "HKCU:\Software\Classes\.j" -Name "(Default)" -Value "JSourceFile"
    
    New-Item -Path "HKCU:\Software\Classes\JSourceFile" -Force | Out-Null
    Set-ItemProperty -Path "HKCU:\Software\Classes\JSourceFile" -Name "(Default)" -Value "J Source File"
    
    if (Test-Path "$InstallDir\J_lang_logo.ico") {
        New-Item -Path "HKCU:\Software\Classes\JSourceFile\DefaultIcon" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Classes\JSourceFile\DefaultIcon" -Name "(Default)" -Value "$InstallDir\J_lang_logo.ico"
    }
    
    New-Item -Path "HKCU:\Software\Classes\JSourceFile\shell\open\command" -Force | Out-Null
    Set-ItemProperty -Path "HKCU:\Software\Classes\JSourceFile\shell\open\command" -Name "(Default)" -Value "`"$BinDir\j.exe`" run `"%1`""
    
    Write-Host "File association created (.j files)" -ForegroundColor Green
} catch {
    Write-Host "Could not create file association" -ForegroundColor Yellow
}

# Verify installation
Write-Host "Verifying installation..." -ForegroundColor Blue
try {
    $version = & "$BinDir\j.exe" --version 2>&1
    Write-Host "SUCCESS! J is installed" -ForegroundColor Green
    Write-Host "Version: $version" -ForegroundColor Cyan
} catch {
    Write-Host "WARNING: Could not verify installation" -ForegroundColor Yellow
}

# Show next steps
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Installation Complete!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Restart your terminal or run:" -ForegroundColor White
Write-Host "   `$env:Path = [System.Environment]::GetEnvironmentVariable('Path','User')" -ForegroundColor Blue
Write-Host ""
Write-Host "2. Verify installation:" -ForegroundColor White
Write-Host "   j --version" -ForegroundColor Blue
Write-Host ""
Write-Host "3. Start the REPL:" -ForegroundColor White
Write-Host "   j repl" -ForegroundColor Blue
Write-Host ""
Write-Host "4. Run an example:" -ForegroundColor White
Write-Host "   j run `"$ExamplesDir\basic.j`"" -ForegroundColor Blue
Write-Host ""
Write-Host "5. Create a project:" -ForegroundColor White
Write-Host "   j jolt init my-project" -ForegroundColor Blue
Write-Host ""
Write-Host "Installation directory: $InstallDir" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
