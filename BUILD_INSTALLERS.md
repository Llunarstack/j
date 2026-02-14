# How to Build J Language Installers

Quick guide to build EXE and MSI installers for J Language.

---

## 🎯 What You're Building

**Goal:** Create professional Windows installers (EXE or MSI) that install J Language

**What they do:**
- Install `j.exe` (the J compiler/interpreter)
- Add J to PATH
- Set up file associations for .j files with the J icon
- Create Start Menu shortcuts
- Add uninstaller

---

## 📦 Option 1: Build EXE Installer (Inno Setup) - RECOMMENDED

### Step 1: Install Inno Setup

1. Go to: https://jrsoftware.org/isdl.php
2. Download "Inno Setup 6.x"
3. Run the installer
4. Install to default location

### Step 2: Build the Installer

```powershell
# Navigate to installers directory
cd j-lang\installers

# Build the EXE installer
& "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" j-lang-setup.iss
```

### Step 3: Find Your Installer

**Location:** `j-lang\dist\installers\j-lang-0.1.0-windows-setup.exe`

**Size:** ~2 MB (includes j.exe)

### Step 4: Test It

```powershell
# Run the installer
.\dist\installers\j-lang-0.1.0-windows-setup.exe
```

Follow the wizard to install J!

---

## 📦 Option 2: Build MSI Installer (WiX Toolset)

### Step 1: Install WiX Toolset

1. Go to: https://wixtoolset.org/releases/
2. Download "WiX Toolset v3.11" or later
3. Run the installer
4. Install to default location

### Step 2: Build the Installer

```powershell
# Navigate to installers directory
cd j-lang\installers

# Run the build script
.\build-msi.ps1
```

### Step 3: Find Your Installer

**Location:** `j-lang\dist\installers\j-lang-0.1.0-windows-x64.msi`

**Size:** ~2 MB (includes j.exe)

### Step 4: Test It

```powershell
# Install via command line
msiexec /i dist\installers\j-lang-0.1.0-windows-x64.msi

# Or double-click the .msi file
```

---

## 📦 Option 3: Use PowerShell Script (No Build Required)

**Already works! No installation needed!**

```powershell
cd j-lang\installers
.\install.ps1
```

This installs J immediately without needing to build anything.

---

## 🎨 Icon Configuration

All installers automatically configure the J icon for .j files:

**Icon file:** `j-lang/J_lang_logo.ico`

**What happens:**
1. Icon is copied to installation directory
2. Registry keys are set to associate .j files with the icon
3. All .j files show the J icon in Windows Explorer
4. Double-clicking a .j file runs it with J

**Already configured in:**
- ✅ `install.ps1` - Lines 122-126, 153-157
- ✅ `j-lang-setup.iss` - Lines 25, 58, 65, 69, 75
- ✅ `j-lang.wxs` - Lines 60-65, 148

---

## 📊 Comparison

| Method | Build Tool | Output | Size | GUI | Best For |
|--------|-----------|--------|------|-----|----------|
| PowerShell | None | N/A | N/A | No | Quick install |
| Inno Setup | Inno Setup | .exe | ~2 MB | Yes | End users |
| WiX | WiX Toolset | .msi | ~2 MB | Yes | Enterprise |

---

## 🚀 Quick Start (Easiest)

**Don't want to build installers? Use the script:**

```powershell
cd j-lang\installers
.\install.ps1
```

**Done!** J is now installed with icon configured.

---

## 🔧 Troubleshooting

### "ISCC.exe not found"

**Solution:** Install Inno Setup from https://jrsoftware.org/isdl.php

### "candle.exe not found"

**Solution:** Install WiX Toolset from https://wixtoolset.org/releases/

### "Executable not found"

**Solution:** Build J first:
```powershell
cd j-lang
cargo build --release
```

### Icon not showing for .j files

**Solution:** 
1. Restart Windows Explorer (or reboot)
2. Check icon file exists: `j-lang\J_lang_logo.ico`
3. Re-run installer

---

## 📝 Summary

**To build EXE installer:**
1. Install Inno Setup
2. Run: `iscc j-lang-setup.iss`
3. Get: `j-lang-0.1.0-windows-setup.exe`

**To build MSI installer:**
1. Install WiX Toolset
2. Run: `.\build-msi.ps1`
3. Get: `j-lang-0.1.0-windows-x64.msi`

**To install without building:**
1. Run: `.\install.ps1`
2. Done!

**All methods configure the J icon for .j files automatically!**

---

**Version:** 0.1.0  
**Last Updated:** February 13, 2026
