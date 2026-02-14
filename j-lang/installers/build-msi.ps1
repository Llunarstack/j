# J Language - Build MSI Installer
# Creates a Windows MSI installer using WiX Toolset

param(
    [string]$Version = "0.1.0",
    [string]$Architecture = "x64"
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  J Language - MSI Installer Builder" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Check for WiX Toolset
Write-Host "Checking for WiX Toolset..." -ForegroundColor Blue

$WixPath = $null
$WixLocations = @(
    "${env:ProgramFiles(x86)}\WiX Toolset v3.11\bin",
    "${env:ProgramFiles}\WiX Toolset v3.11\bin",
    "${env:ProgramFiles(x86)}\WiX Toolset v3.14\bin",
    "${env:ProgramFiles}\WiX Toolset v3.14\bin",
    "${env:WIX}bin"
)

foreach ($Location in $WixLocations) {
    if (Test-Path "$Location\candle.exe") {
        $WixPath = $Location
        break
    }
}

if (-not $WixPath) {
    Write-Host ""
    Write-Host "ERROR: WiX Toolset not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install WiX Toolset:" -ForegroundColor Yellow
    Write-Host "  1. Download from: https://wixtoolset.org/releases/" -ForegroundColor Blue
    Write-Host "  2. Install WiX Toolset v3.11 or later" -ForegroundColor Blue
    Write-Host "  3. Run this script again" -ForegroundColor Blue
    Write-Host ""
    Write-Host "Alternative: Use Inno Setup installer instead" -ForegroundColor Gray
    Write-Host "  Run: iscc j-lang-setup.iss" -ForegroundColor Gray
    Write-Host ""
    exit 1
}

Write-Host "Found WiX at: $WixPath" -ForegroundColor Green

# Configuration
$ProjectRoot = Split-Path -Parent $PSScriptRoot
$InstallersDir = $PSScriptRoot
$DistDir = Join-Path $ProjectRoot "dist"
$InstallerDistDir = Join-Path $DistDir "installers"

# Create directories
if (-not (Test-Path $InstallerDistDir)) {
    New-Item -ItemType Directory -Path $InstallerDistDir | Out-Null
}

# Check for executable
$ExePath = Join-Path $DistDir "j-windows-$Architecture.exe"
if (-not (Test-Path $ExePath)) {
    Write-Host ""
    Write-Host "ERROR: Executable not found: $ExePath" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please build first:" -ForegroundColor Yellow
    Write-Host "  cd .." -ForegroundColor Blue
    Write-Host "  cargo build --release" -ForegroundColor Blue
    Write-Host ""
    exit 1
}

Write-Host "Using executable: $ExePath" -ForegroundColor Green

# Build MSI
Write-Host ""
Write-Host "Building MSI installer..." -ForegroundColor Blue
Write-Host ""

$WxsFile = Join-Path $InstallersDir "j-lang.wxs"
$WixObjFile = Join-Path $InstallersDir "j-lang.wixobj"
$MsiFile = Join-Path $InstallerDistDir "j-lang-$Version-windows-$Architecture.msi"

try {
    # Compile WiX source
    Write-Host "Compiling WiX source..." -ForegroundColor Blue
    & "$WixPath\candle.exe" -nologo -arch $Architecture -out $WixObjFile $WxsFile
    
    if ($LASTEXITCODE -ne 0) {
        throw "WiX compilation failed"
    }
    
    # Link MSI
    Write-Host "Linking MSI..." -ForegroundColor Blue
    & "$WixPath\light.exe" -nologo -ext WixUIExtension -out $MsiFile $WixObjFile
    
    if ($LASTEXITCODE -ne 0) {
        throw "WiX linking failed"
    }
    
    # Clean up
    Remove-Item $WixObjFile -ErrorAction SilentlyContinue
    
    # Success
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "  MSI Installer Created Successfully!" -ForegroundColor Green
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""
    
    $MsiSize = [math]::Round((Get-Item $MsiFile).Length / 1MB, 2)
    Write-Host "File: $MsiFile" -ForegroundColor Cyan
    Write-Host "Size: $MsiSize MB" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "To install:" -ForegroundColor Yellow
    Write-Host "  msiexec /i `"$MsiFile`"" -ForegroundColor Blue
    Write-Host ""
    Write-Host "Or double-click the MSI file" -ForegroundColor Gray
    Write-Host ""
    
} catch {
    Write-Host ""
    Write-Host "ERROR: Failed to build MSI" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    exit 1
}
