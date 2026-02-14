# J Language - PowerShell Installer
# Installs J, sets up PATH, and registers file associations.

param (
    [switch]$Uninstall
)

$AppName = "J"
$InstallDir = "$env:LOCALAPPDATA\J"
$BinDir = "$InstallDir\bin"
$ExamplesDir = "$InstallDir\examples"
$ExeName = "j.exe"
$IconName = "J_lang_logo.ico"

# Try to find the binary in common build locations
$SourceExe = "..\target\release\j.exe"
if (-not (Test-Path $SourceExe)) { $SourceExe = "..\dist\j-windows-x86_64.exe" }
if (-not (Test-Path $SourceExe)) { $SourceExe = ".\j.exe" }

if ($Uninstall) {
    Write-Host "Uninstalling J Language..." -ForegroundColor Yellow
    
    # 1. Remove Files
    if (Test-Path $InstallDir) {
        Remove-Item -Recurse -Force $InstallDir
        Write-Host "Removed installation directory."
    }
    
    # 2. Remove from PATH
    $CurrentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($CurrentPath -like "*$BinDir*") {
        $NewPath = $CurrentPath.Replace(";$BinDir", "").Replace("$BinDir;", "").Replace($BinDir, "")
        [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
        Write-Host "Removed from PATH."
    }

    # 3. Remove Registry Keys
    Remove-Item "HKCU:\Software\Classes\.j" -Recurse -ErrorAction SilentlyContinue
    Remove-Item "HKCU:\Software\Classes\JSourceFile" -Recurse -ErrorAction SilentlyContinue
    Write-Host "Removed file associations."

    Write-Host "Uninstalled successfully." -ForegroundColor Green
    return
}

# --- Install Logic ---
Write-Host "Installing J Language..." -ForegroundColor Cyan

# 1. Check for Binary
if (-not (Test-Path $SourceExe)) {
    Write-Error "Could not find j.exe binary!`nPlease run 'cargo build --release' in the j-lang directory first."
    return
}

# 2. Create Directories
New-Item -ItemType Directory -Force -Path $BinDir | Out-Null
New-Item -ItemType Directory -Force -Path $ExamplesDir | Out-Null

# 3. Copy Files
Copy-Item $SourceExe "$BinDir\$ExeName" -Force
Write-Host "✅ Binary installed to $BinDir\$ExeName"

$SourceExamples = "..\examples"
if (Test-Path $SourceExamples) {
    Copy-Item "$SourceExamples\*" $ExamplesDir -Recurse -Force
    Write-Host "✅ Examples installed to $ExamplesDir"
}

# 3b. Copy Icon
$SourceIcon = "..\..\J_lang_logo.ico"
if (Test-Path $SourceIcon) {
    Copy-Item $SourceIcon "$InstallDir\$IconName" -Force
    Write-Host "✅ Icon installed to $InstallDir\$IconName"
}

# 4. Add to PATH
$CurrentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($CurrentPath -notlike "*$BinDir*") {
    $NewPath = "$CurrentPath;$BinDir"
    [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
    $env:Path = $NewPath # Update current session
    Write-Host "✅ Added to PATH environment variable."
} else {
    Write-Host "✅ Already in PATH."
}

# 5. Register File Associations (HKCU - No Admin needed)
try {
    # Associate .j with JSourceFile
    New-Item "HKCU:\Software\Classes\.j" -Force | Out-Null
    Set-ItemProperty "HKCU:\Software\Classes\.j" -Name "(default)" -Value "JSourceFile"
    
    # Define JSourceFile
    New-Item "HKCU:\Software\Classes\JSourceFile" -Force | Out-Null
    Set-ItemProperty "HKCU:\Software\Classes\JSourceFile" -Name "(default)" -Value "J Source File"
    
    # Set Icon and Open Command
    $IconPath = "$BinDir\$ExeName,0"
    if (Test-Path "$InstallDir\$IconName") {
        $IconPath = "$InstallDir\$IconName"
    }

    New-Item "HKCU:\Software\Classes\JSourceFile\DefaultIcon" -Force | Out-Null
    Set-ItemProperty "HKCU:\Software\Classes\JSourceFile\DefaultIcon" -Name "(default)" -Value $IconPath
    
    New-Item "HKCU:\Software\Classes\JSourceFile\shell\open\command" -Force | Out-Null
    Set-ItemProperty "HKCU:\Software\Classes\JSourceFile\shell\open\command" -Name "(default)" -Value "`"$BinDir\$ExeName`" run `"%1`""
    
    Write-Host "✅ Registered .j file extension (Double-click to run)."
} catch {
    Write-Warning "Could not set file associations."
}

Write-Host "`n🎉 Installation Complete! Please restart your terminal to use 'j' command." -ForegroundColor Green