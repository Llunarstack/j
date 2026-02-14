# J Language - Visual Studio Build Tools Installation Helper

Write-Host "🔧 J Language Build Tools Setup" -ForegroundColor Green
Write-Host ""

# Check if Visual Studio Build Tools are already installed
$vsWhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
$buildToolsInstalled = $false

if (Test-Path $vsWhere) {
    $installations = & $vsWhere -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -format json | ConvertFrom-Json
    if ($installations.Count -gt 0) {
        $buildToolsInstalled = $true
        Write-Host "✅ Visual Studio Build Tools are already installed!" -ForegroundColor Green
    }
}

if (-not $buildToolsInstalled) {
    Write-Host "❌ Visual Studio Build Tools not found" -ForegroundColor Red
    Write-Host ""
    Write-Host "To enable LLVM compilation and JIT features, you need Visual Studio Build Tools." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Options to install:" -ForegroundColor Cyan
    Write-Host "1. 🚀 Quick Install (Recommended)" -ForegroundColor White
    Write-Host "   Download and install Build Tools automatically" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. 📥 Manual Install" -ForegroundColor White
    Write-Host "   Open download page in browser" -ForegroundColor Gray
    Write-Host ""
    Write-Host "3. ⏭️  Skip (Use interpreter mode only)" -ForegroundColor White
    Write-Host "   Continue without compilation features" -ForegroundColor Gray
    Write-Host ""
    
    $choice = Read-Host "Choose option (1/2/3)"
    
    switch ($choice) {
        "1" {
            Write-Host "🚀 Starting automatic installation..." -ForegroundColor Green
            
            # Download Build Tools installer
            $installerUrl = "https://aka.ms/vs/17/release/vs_buildtools.exe"
            $installerPath = "$env:TEMP\vs_buildtools.exe"
            
            Write-Host "📥 Downloading Visual Studio Build Tools..." -ForegroundColor Yellow
            try {
                Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath -UseBasicParsing
                Write-Host "✅ Download complete" -ForegroundColor Green
                
                Write-Host "🔧 Installing Build Tools with C++ support..." -ForegroundColor Yellow
                Write-Host "   This may take several minutes..." -ForegroundColor Gray
                
                # Install with C++ build tools
                $process = Start-Process -FilePath $installerPath -ArgumentList @(
                    "--quiet",
                    "--wait",
                    "--add", "Microsoft.VisualStudio.Workload.VCTools",
                    "--add", "Microsoft.VisualStudio.Component.VC.Tools.x86.x64",
                    "--add", "Microsoft.VisualStudio.Component.Windows10SDK.20348"
                ) -PassThru -Wait
                
                if ($process.ExitCode -eq 0) {
                    Write-Host "✅ Visual Studio Build Tools installed successfully!" -ForegroundColor Green
                    Write-Host "🔄 Please restart your terminal/PowerShell session" -ForegroundColor Yellow
                } else {
                    Write-Host "❌ Installation failed with exit code: $($process.ExitCode)" -ForegroundColor Red
                    Write-Host "💡 Try manual installation instead" -ForegroundColor Yellow
                }
                
                # Clean up installer
                Remove-Item $installerPath -ErrorAction SilentlyContinue
                
            } catch {
                Write-Host "❌ Download failed: $($_.Exception.Message)" -ForegroundColor Red
                Write-Host "💡 Try manual installation instead" -ForegroundColor Yellow
            }
        }
        
        "2" {
            Write-Host "🌐 Opening Visual Studio Build Tools download page..." -ForegroundColor Green
            Start-Process "https://visualstudio.microsoft.com/visual-cpp-build-tools/"
            Write-Host ""
            Write-Host "📋 Installation Instructions:" -ForegroundColor Cyan
            Write-Host "1. Download 'Build Tools for Visual Studio'" -ForegroundColor White
            Write-Host "2. Run the installer" -ForegroundColor White
            Write-Host "3. Select 'C++ build tools' workload" -ForegroundColor White
            Write-Host "4. Install and restart your terminal" -ForegroundColor White
            Write-Host "5. Run this script again to verify installation" -ForegroundColor White
        }
        
        "3" {
            Write-Host "⏭️  Skipping Build Tools installation" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "📝 You can still use J Language in interpreter mode:" -ForegroundColor Cyan
            Write-Host "   cargo run -- repl" -ForegroundColor White
            Write-Host "   cargo run -- run file.j" -ForegroundColor White
            Write-Host ""
            Write-Host "🔧 To enable compilation later, run this script again" -ForegroundColor Gray
        }
        
        default {
            Write-Host "❌ Invalid choice. Exiting." -ForegroundColor Red
            exit 1
        }
    }
} else {
    Write-Host "🎉 All build tools are ready!" -ForegroundColor Green
}

Write-Host ""
Write-Host "🧪 Testing J Language build..." -ForegroundColor Yellow

# Test basic build
try {
    $buildResult = cargo build 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Basic build successful!" -ForegroundColor Green
        
        # Test with LLVM features if build tools are installed
        if ($buildToolsInstalled) {
            Write-Host "🔥 Testing LLVM features..." -ForegroundColor Yellow
            $llvmBuildResult = cargo build --features llvm 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ LLVM features working!" -ForegroundColor Green
                Write-Host ""
                Write-Host "🚀 J Language is fully ready! You can now:" -ForegroundColor Green
                Write-Host "   • cargo run -- repl (Interactive mode)" -ForegroundColor White
                Write-Host "   • cargo run -- run file.j (Interpreter)" -ForegroundColor White
                Write-Host "   • cargo run -- build file.j (LLVM compilation)" -ForegroundColor White
            } else {
                Write-Host "⚠️  LLVM build failed, but basic features work" -ForegroundColor Yellow
                Write-Host "   You can still use interpreter mode" -ForegroundColor Gray
            }
        }
    } else {
        Write-Host "❌ Build failed:" -ForegroundColor Red
        Write-Host $buildResult -ForegroundColor Gray
    }
} catch {
    Write-Host "❌ Build test failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "📚 For more information, see README.md" -ForegroundColor Cyan