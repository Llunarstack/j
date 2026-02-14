# J Language - Build All Platform Executables
# Builds executables for Windows, Linux, and macOS

param(
    [switch]$SkipTests = $false
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  J Language - Multi-Platform Build Script" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$ProjectRoot = Split-Path -Parent $PSScriptRoot
$DistDir = Join-Path $ProjectRoot "dist"

# Create dist directory
if (-not (Test-Path $DistDir)) {
    New-Item -ItemType Directory -Path $DistDir | Out-Null
}

# Targets to build
$Targets = @(
    @{Name="Windows x64"; Target="x86_64-pc-windows-msvc"; Output="j-windows-x86_64.exe"; Extension=".exe"}
    @{Name="Windows x86"; Target="i686-pc-windows-msvc"; Output="j-windows-i686.exe"; Extension=".exe"}
    @{Name="Windows ARM64"; Target="aarch64-pc-windows-msvc"; Output="j-windows-aarch64.exe"; Extension=".exe"}
    @{Name="Linux x64"; Target="x86_64-unknown-linux-gnu"; Output="j-linux-x86_64"; Extension=""}
    @{Name="Linux x86"; Target="i686-unknown-linux-gnu"; Output="j-linux-i686"; Extension=""}
    @{Name="Linux ARM64"; Target="aarch64-unknown-linux-gnu"; Output="j-linux-aarch64"; Extension=""}
    @{Name="Linux ARMv7"; Target="armv7-unknown-linux-gnueabihf"; Output="j-linux-armv7"; Extension=""}
    @{Name="macOS Intel"; Target="x86_64-apple-darwin"; Output="j-macos-x86_64"; Extension=""}
    @{Name="macOS Apple Silicon"; Target="aarch64-apple-darwin"; Output="j-macos-aarch64"; Extension=""}
)

$BuiltCount = 0
$FailedCount = 0
$SkippedCount = 0

foreach ($Target in $Targets) {
    Write-Host ""
    Write-Host "Building: $($Target.Name)" -ForegroundColor Yellow
    Write-Host "Target: $($Target.Target)" -ForegroundColor Gray
    
    # Check if target is installed
    $TargetInstalled = rustup target list | Select-String $Target.Target | Select-String "installed"
    
    if (-not $TargetInstalled) {
        Write-Host "Installing target..." -ForegroundColor Blue
        try {
            rustup target add $Target.Target 2>&1 | Out-Null
        } catch {
            Write-Host "Failed to install target: $($Target.Target)" -ForegroundColor Red
            Write-Host "Skipping..." -ForegroundColor Yellow
            $SkippedCount++
            continue
        }
    }
    
    # Build
    Write-Host "Compiling..." -ForegroundColor Blue
    try {
        $BuildOutput = cargo build --release --target $Target.Target 2>&1
        
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Build failed!" -ForegroundColor Red
            Write-Host "Error: Linker or toolchain not available" -ForegroundColor Yellow
            Write-Host "This is normal for cross-compilation on Windows" -ForegroundColor Gray
            $FailedCount++
            continue
        }
        
        # Copy to dist
        $SourcePath = Join-Path $ProjectRoot "target\$($Target.Target)\release\j$($Target.Extension)"
        $DestPath = Join-Path $DistDir $Target.Output
        
        if (Test-Path $SourcePath) {
            Copy-Item $SourcePath $DestPath -Force
            $Size = [math]::Round((Get-Item $DestPath).Length / 1MB, 2)
            Write-Host "SUCCESS! Built: $($Target.Output) ($Size MB)" -ForegroundColor Green
            $BuiltCount++
        } else {
            Write-Host "Build succeeded but executable not found" -ForegroundColor Yellow
            $FailedCount++
        }
        
    } catch {
        Write-Host "Build failed: $_" -ForegroundColor Red
        $FailedCount++
    }
}

# Summary
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Build Summary" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Built: $BuiltCount" -ForegroundColor Green
Write-Host "Failed: $FailedCount" -ForegroundColor $(if ($FailedCount -gt 0) { "Yellow" } else { "Gray" })
Write-Host "Skipped: $SkippedCount" -ForegroundColor $(if ($SkippedCount -gt 0) { "Yellow" } else { "Gray" })
Write-Host ""

# List built executables
if ($BuiltCount -gt 0) {
    Write-Host "Built Executables:" -ForegroundColor Cyan
    Get-ChildItem $DistDir | Where-Object { $_.Name -like "j-*" } | ForEach-Object {
        $Size = [math]::Round($_.Length / 1MB, 2)
        Write-Host "  $($_.Name) - $Size MB" -ForegroundColor Green
    }
    Write-Host ""
}

# Notes
if ($FailedCount -gt 0 -or $SkippedCount -gt 0) {
    Write-Host "Notes:" -ForegroundColor Yellow
    Write-Host "  - Cross-compilation on Windows requires additional toolchains" -ForegroundColor Gray
    Write-Host "  - Linux/macOS builds need native compilation or CI/CD" -ForegroundColor Gray
    Write-Host "  - ARM64 Windows needs Visual Studio ARM64 tools" -ForegroundColor Gray
    Write-Host "  - Use GitHub Actions for full multi-platform builds" -ForegroundColor Gray
    Write-Host ""
}

Write-Host "Done!" -ForegroundColor Green
Write-Host ""
