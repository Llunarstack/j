# J Language VSCode Setup Script

Write-Host "🚀 Setting up J Language for VSCode..." -ForegroundColor Green

# Check if VSCode is installed
$vscodeCmd = Get-Command code -ErrorAction SilentlyContinue
if (-not $vscodeCmd) {
    Write-Host "❌ VSCode not found. Please install VSCode first." -ForegroundColor Red
    exit 1
}

Write-Host "✅ VSCode found" -ForegroundColor Green

# Install recommended extensions
Write-Host "📦 Installing recommended extensions..." -ForegroundColor Yellow

$extensions = @(
    "ms-vscode.cpptools",
    "rust-lang.rust-analyzer", 
    "formulahendry.code-runner",
    "ms-vscode.vscode-json"
)

foreach ($ext in $extensions) {
    Write-Host "Installing $ext..." -ForegroundColor Cyan
    code --install-extension $ext
}

# Build the project
Write-Host "🔨 Building J Language..." -ForegroundColor Yellow
cargo build

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Build successful!" -ForegroundColor Green
} else {
    Write-Host "❌ Build failed. Please check the error messages above." -ForegroundColor Red
    exit 1
}

# Test the installation
Write-Host "🧪 Testing installation..." -ForegroundColor Yellow
$testResult = cargo run -- check test.j 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ J Language is working correctly!" -ForegroundColor Green
} else {
    Write-Host "⚠️  Warning: Test failed, but installation may still work." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎉 Setup complete! You can now:" -ForegroundColor Green
Write-Host "   • Open .j files in VSCode with syntax highlighting" -ForegroundColor White
Write-Host "   • Press Ctrl+F5 to run J files" -ForegroundColor White  
Write-Host "   • Press Ctrl+Shift+C to check syntax" -ForegroundColor White
Write-Host "   • Use 'cargo run -- repl' for interactive mode" -ForegroundColor White
Write-Host "   • Use 'cargo run -- build file.j' for LLVM compilation" -ForegroundColor White
Write-Host "   • Try the demo: cargo run -- run test.j" -ForegroundColor White
Write-Host ""
Write-Host "🔥 Advanced features:" -ForegroundColor Yellow
Write-Host "   • LLVM-based native compilation" -ForegroundColor White
Write-Host "   • Infinity values (inf, -inf)" -ForegroundColor White
Write-Host "   • Rich type system (money, dates, hex colors)" -ForegroundColor White
Write-Host "   • Enhanced string escapes (Unicode, ANSI)" -ForegroundColor White
Write-Host "   • File execution with j; -> filename.j" -ForegroundColor White
Write-Host ""
Write-Host "📚 Open README.md for full documentation" -ForegroundColor Cyan