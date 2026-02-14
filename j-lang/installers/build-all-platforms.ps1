# J Language - Cross-Platform Build Script
# Builds binaries for all supported platforms and architectures

param(
    [switch]$Release = $true,
    [switch]$SkipTests = $false
)

Write-Host "🚀 J Language - Multi-Platform Build System" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# Check if cross is installed
$crossInstalled = Get-Command cross -ErrorAction SilentlyContinue
if (-not $crossInstalled) {
    Write-Host "⚠️  'cross' not found. Installing..." -ForegroundColor Yellow
    cargo install cross --git https://github.com/cross-rs/cross
}

# Check if cargo is installed
$cargoInstalled = Get-Command cargo -ErrorAction SilentlyContinue
if (-not $cargoInstalled) {
    Write-Host "❌ Cargo not found. Please install Rust from https://rustup.rs/" -ForegroundColor Red
    exit 1
}

# Create output directory
$outputDir = "dist"
if (Test-Path $outputDir) {
    Remove-Item -Recurse -Force $outputDir
}
New-Item -ItemType Directory -Path $outputDir | Out-Null

# Define target platforms
$targets = @(
    # Windows
    @{Name="windows-x86_64"; Target="x86_64-pc-windows-msvc"; Ext=".exe"},
    @{Name="windows-i686"; Target="i686-pc-windows-msvc"; Ext=".exe"},
    @{Name="windows-aarch64"; Target="aarch64-pc-windows-msvc"; Ext=".exe"},
    
    # Linux
    @{Name="linux-x86_64"; Target="x86_64-unknown-linux-gnu"; Ext=""},
    @{Name="linux-i686"; Target="i686-unknown-linux-gnu"; Ext=""},
    @{Name="linux-aarch64"; Target="aarch64-unknown-linux-gnu"; Ext=""},
    @{Name="linux-armv7"; Target="armv7-unknown-linux-gnueabihf"; Ext=""},
    @{Name="linux-arm"; Target="arm-unknown-linux-gnueabihf"; Ext=""},
    
    # macOS
    @{Name="macos-x86_64"; Target="x86_64-apple-darwin"; Ext=""},
    @{Name="macos-aarch64"; Target="aarch64-apple-darwin"; Ext=""},
    
    # FreeBSD
    @{Name="freebsd-x86_64"; Target="x86_64-unknown-freebsd"; Ext=""}
)

$buildMode = if ($Release) { "release" } else { "debug" }
$buildFlag = if ($Release) { "--release" } else { "" }

Write-Host "📦 Building for $($targets.Count) platforms..." -ForegroundColor Green
Write-Host "   Build mode: $buildMode" -ForegroundColor Gray
Write-Host ""

$successCount = 0
$failCount = 0
$results = @()

foreach ($target in $targets) {
    Write-Host "🔨 Building: $($target.Name) ($($target.Target))..." -ForegroundColor Yellow
    
    # Add target if not already added
    rustup target add $target.Target 2>$null
    
    # Build
    $buildCmd = if ($target.Target -like "*windows*" -or $target.Target -like "*darwin*") {
        "cargo build $buildFlag --target $($target.Target)"
    } else {
        "cross build $buildFlag --target $($target.Target)"
    }
    
    try {
        Invoke-Expression $buildCmd 2>&1 | Out-Null
        
        # Check if build succeeded
        $binaryPath = "target\$($target.Target)\$buildMode\j$($target.Ext)"
        if (Test-Path $binaryPath) {
            # Copy to dist
            $distPath = "$outputDir\j-$($target.Name)$($target.Ext)"
            Copy-Item $binaryPath $distPath
            
            # Get file size
            $size = (Get-Item $distPath).Length / 1MB
            
            Write-Host "   ✅ Success! Size: $([math]::Round($size, 2)) MB" -ForegroundColor Green
            $successCount++
            $results += @{Platform=$target.Name; Status="✅ Success"; Size="$([math]::Round($size, 2)) MB"}
        } else {
            Write-Host "   ❌ Failed: Binary not found" -ForegroundColor Red
            $failCount++
            $results += @{Platform=$target.Name; Status="❌ Failed"; Size="N/A"}
        }
    } catch {
        Write-Host "   ❌ Failed: $($_.Exception.Message)" -ForegroundColor Red
        $failCount++
        $results += @{Platform=$target.Name; Status="❌ Failed"; Size="N/A"}
    }
    
    Write-Host ""
}

# Summary
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "📊 Build Summary" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

foreach ($result in $results) {
    Write-Host "  $($result.Platform.PadRight(20)) $($result.Status.PadRight(15)) $($result.Size)" -ForegroundColor $(if ($result.Status -like "*Success*") { "Green" } else { "Red" })
}

Write-Host ""
Write-Host "Total: $successCount succeeded, $failCount failed" -ForegroundColor $(if ($failCount -eq 0) { "Green" } else { "Yellow" })
Write-Host ""
Write-Host "📁 Binaries available in: $outputDir\" -ForegroundColor Cyan
Write-Host ""

# Create checksums
if ($successCount -gt 0) {
    Write-Host "🔐 Generating checksums..." -ForegroundColor Yellow
    $checksumFile = "$outputDir\checksums.txt"
    Get-ChildItem $outputDir -Filter "j-*" | ForEach-Object {
        $hash = (Get-FileHash $_.FullName -Algorithm SHA256).Hash
        "$hash  $($_.Name)" | Out-File -Append -FilePath $checksumFile -Encoding UTF8
    }
    Write-Host "   ✅ Checksums saved to: checksums.txt" -ForegroundColor Green
    Write-Host ""
}

Write-Host "✨ Build complete!" -ForegroundColor Green
