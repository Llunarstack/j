# J Language Installers Explained

## What's the Difference?

### The Confusion Cleared Up

**Q: Why are we using .ps1 and not .exe?**

**A:** We have BOTH! Here's what each file does:

---

## 📦 What You Have

### 1. The J Language Program (j.exe)

**Location:** `j-lang/dist/j-windows-x86_64.exe`

This IS the actual J programming language compiler/interpreter. This is what you use to run J programs.

**What it does:**
- Compiles J code
- Runs J programs
- Provides the REPL
- This is the FINAL PROGRAM

**How to use:**
```bash
j.exe --version
j.exe repl
j.exe run myprogram.j
```

---

### 2. The Installers (Multiple Types)

These are tools that INSTALL j.exe onto your computer. You have 4 options:

#### Option A: PowerShell Script Installer (install.ps1)

**File:** `j-lang/installers/install.ps1`

**What it is:** A script that automatically installs J

**What it does:**
1. Copies j.exe to your computer
2. Adds J to your PATH
3. Creates file associations for .j files
4. Sets up the icon for .j files
5. Copies examples

**How to use:**
```powershell
cd j-lang\installers
.\install.ps1
```

**After running this, you have j.exe installed and can use it!**

#### Option B: EXE Installer (Inno Setup)

**File:** `j-lang/installers/j-lang-setup.iss` (source)  
**Output:** `j-lang-0.1.0-windows-setup.exe` (after building)

**What it is:** A professional Windows installer with a GUI wizard

**What it does:** Same as the PowerShell script, but with a nice GUI

**How to build:**
```powershell
# Install Inno Setup first from https://jrsoftware.org/isdl.php
cd j-lang\installers
iscc j-lang-setup.iss
```

**Output:** Creates `dist/installers/j-lang-0.1.0-windows-setup.exe`

**How to use:** Double-click the .exe file and follow the wizard

#### Option C: MSI Installer (Windows Installer)

**File:** `j-lang/installers/j-lang.wxs` (source)  
**Output:** `j-lang-0.1.0-windows-x64.msi` (after building)

**What it is:** A professional Windows MSI installer

**What it does:** Same as above, but uses Windows Installer technology

**How to build:**
```powershell
# Install WiX Toolset first from https://wixtoolset.org/releases/
cd j-lang\installers
.\build-msi.ps1
```

**Output:** Creates `dist/installers/j-lang-0.1.0-windows-x64.msi`

**How to use:** Double-click the .msi file or run `msiexec /i j-lang-0.1.0-windows-x64.msi`

#### Option D: Bash Script Installer (Linux/macOS)

**File:** `j-lang/installers/install.sh`

**What it is:** A script that automatically installs J on Linux/macOS

**How to use:**
```bash
cd j-lang/installers
chmod +x install.sh
./install.sh
```

---

## 🎯 Simple Explanation

```
j.exe = The J programming language (the actual program)
  ↑
  |
  | (installed by)
  |
install.ps1 = Installer script (sets up j.exe)
  OR
j-lang-setup.exe = GUI installer (sets up j.exe)
  OR
j-lang-setup.msi = MSI installer (sets up j.exe)
```

---

## 🚀 Quick Start

**For most users (easiest):**

```powershell
# This installs J automatically
cd j-lang\installers
.\install.ps1

# Now you can use J
j --version
j repl
```

**For users who want a GUI installer:**

1. Build the EXE installer:
   ```powershell
   # Install Inno Setup from https://jrsoftware.org/isdl.php
   cd j-lang\installers
   iscc j-lang-setup.iss
   ```

2. Run the installer:
   ```powershell
   # Double-click this file:
   dist\installers\j-lang-0.1.0-windows-setup.exe
   ```

3. Follow the wizard

---

## 🎨 Icon for .j Files

All installers automatically set up the J icon for .j files:

**Icon file:** `j-lang/J_lang_logo.ico`

**What happens:**
1. When you install J (using any installer)
2. All .j files get the J icon
3. Double-clicking a .j file runs it with J
4. Right-click → "Edit" opens it in notepad

**The icon is already configured in:**
- ✅ `install.ps1` (PowerShell installer)
- ✅ `j-lang-setup.iss` (Inno Setup installer)
- ✅ `j-lang.wxs` (MSI installer)

---

## 📊 Comparison

| Installer Type | File | Requires | GUI | Best For |
|---------------|------|----------|-----|----------|
| PowerShell Script | install.ps1 | Nothing | No | Quick install |
| Inno Setup EXE | j-lang-setup.exe | Inno Setup to build | Yes | End users |
| MSI | j-lang-setup.msi | WiX to build | Yes | Enterprise |
| Bash Script | install.sh | Nothing | No | Linux/macOS |

---

## 🔧 Current Status

**What's ready NOW:**
- ✅ j.exe (Windows x64) - The actual J program
- ✅ j.exe (Windows x86) - The actual J program
- ✅ install.ps1 - Working installer (tested)
- ✅ install.sh - Working installer (ready)
- ✅ j-lang-setup.iss - Ready to build EXE installer
- ✅ j-lang.wxs - Ready to build MSI installer

**To get EXE installer:**
1. Install Inno Setup: https://jrsoftware.org/isdl.php
2. Run: `iscc j-lang-setup.iss`
3. Get: `j-lang-0.1.0-windows-setup.exe`

**To get MSI installer:**
1. Install WiX Toolset: https://wixtoolset.org/releases/
2. Run: `.\build-msi.ps1`
3. Get: `j-lang-0.1.0-windows-x64.msi`

---

## 💡 Summary

**You asked: "Why are we using ps1 not exe?"**

**Answer:**
- The `.ps1` file is an INSTALLER (it installs J)
- The `j.exe` file is the ACTUAL PROGRAM (the J language)
- We also have `.iss` and `.wxs` files to BUILD exe/msi installers
- All installers set up the icon for .j files automatically

**What you need to do:**
1. Either use `install.ps1` (works now, no setup needed)
2. Or build the EXE installer with Inno Setup
3. Or build the MSI installer with WiX

**All of them install the same thing: j.exe with the icon configured!**

---

**Version:** 0.1.0  
**Last Updated:** February 13, 2026
