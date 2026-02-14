# J Language - All Installer Options

Complete guide to all available installation methods.

---

## 🎯 Quick Comparison

| Method | File | Build Needed? | Output | Best For |
|--------|------|--------------|--------|----------|
| Batch File | install.bat | ❌ No | N/A | Quick install |
| PowerShell | install.ps1 | ❌ No | N/A | Quick install |
| Visual Studio | installer.cpp | ✅ Yes | j-installer.exe | Distribution |
| Inno Setup | j-lang-setup.iss | ✅ Yes | j-lang-setup.exe | End users |
| MSI | j-lang.wxs | ✅ Yes | j-lang.msi | Enterprise |

---

## 📦 Option 1: Batch File (Easiest)

### No Build Required ✅

**File:** `j-lang/installers/install.bat`

**How to use:**
1. Open File Explorer
2. Navigate to `j-lang\installers\`
3. Double-click `install.bat`
4. Press any key when done

**Advantages:**
- ✅ Works immediately
- ✅ No dependencies
- ✅ No build needed
- ✅ Easy to modify

---

## 📦 Option 2: PowerShell Script

### No Build Required ✅

**File:** `j-lang/installers/install.ps1`

**How to use:**
```powershell
cd j-lang\installers
.\install.ps1
```

**Advantages:**
- ✅ Works immediately
- ✅ No dependencies
- ✅ No build needed
- ✅ More features than batch

---

## 📦 Option 3: Native EXE (Visual Studio)

### Build Required ✅

**File:** `j-lang/installers/installer.cpp`

**How to build:**

1. Open "Developer Command Prompt for VS"
2. Navigate to installers:
   ```cmd
   cd j-lang\installers
   ```
3. Run build script:
   ```cmd
   build-installer-exe.bat
   ```
4. Output: `j-installer.exe`

**How to use:**
```cmd
j-installer.exe
```

**Advantages:**
- ✅ Single .exe file
- ✅ No dependencies
- ✅ Fast execution
- ✅ Professional
- ✅ Can be signed

**Requirements:**
- Visual Studio 2019+ with C++ Desktop Development

**See:** `BUILD_WITH_VISUAL_STUDIO.md` for detailed instructions

---

## 📦 Option 4: Inno Setup EXE (GUI Installer)

### Build Required ✅

**File:** `j-lang/installers/j-lang-setup.iss`

**How to build:**

1. Install Inno Setup from https://jrsoftware.org/isdl.php
2. Navigate to installers:
   ```cmd
   cd j-lang\installers
   ```
3. Build:
   ```cmd
   "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" j-lang-setup.iss
   ```
4. Output: `dist\installers\j-lang-0.1.0-windows-setup.exe`

**How to use:**
- Double-click the .exe file
- Follow the wizard

**Advantages:**
- ✅ Professional GUI wizard
- ✅ Custom install location
- ✅ Desktop icon option
- ✅ Start Menu shortcuts
- ✅ Uninstaller in Add/Remove Programs

**Requirements:**
- Inno Setup 6.x

---

## 📦 Option 5: MSI Installer (Enterprise)

### Build Required ✅

**File:** `j-lang/installers/j-lang.wxs`

**How to build:**

1. Install WiX Toolset from https://wixtoolset.org/releases/
2. Navigate to installers:
   ```powershell
   cd j-lang\installers
   ```
3. Build:
   ```powershell
   .\build-msi.ps1
   ```
4. Output: `dist\installers\j-lang-0.1.0-windows-x64.msi`

**How to use:**
```cmd
msiexec /i j-lang-0.1.0-windows-x64.msi
```
Or double-click the .msi file

**Advantages:**
- ✅ Windows Installer technology
- ✅ Group Policy deployment
- ✅ Enterprise features
- ✅ Repair/Modify options
- ✅ Uninstaller in Add/Remove Programs

**Requirements:**
- WiX Toolset 3.11+

---

## 🎨 What All Installers Do

All 5 methods install the same thing:

✅ **j.exe** - The J compiler/interpreter  
✅ **PATH** - Adds J to your PATH  
✅ **Icon** - Sets up J icon for .j files  
✅ **File Association** - Double-click .j files to run  
✅ **Examples** - Copies example programs  
✅ **Uninstaller** - Provides uninstall method  

**Installation Location:** `%LOCALAPPDATA%\J\`

---

## 🚀 Recommendations

### For Yourself (Quick Install)
Use **Option 1** (Batch File) or **Option 2** (PowerShell)
- No build needed
- Works immediately
- Easy to use

### For Distribution to Users
Use **Option 3** (Visual Studio) or **Option 4** (Inno Setup)
- Professional appearance
- Single .exe file
- GUI wizard (Inno Setup)
- Can be digitally signed

### For Enterprise Deployment
Use **Option 5** (MSI)
- Group Policy support
- Enterprise features
- Standard Windows Installer

---

## 📊 Feature Comparison

| Feature | Batch | PowerShell | VS EXE | Inno Setup | MSI |
|---------|-------|-----------|--------|------------|-----|
| No build needed | ✅ | ✅ | ❌ | ❌ | ❌ |
| Single file | ❌ | ❌ | ✅ | ✅ | ✅ |
| GUI wizard | ❌ | ❌ | ❌ | ✅ | ✅ |
| Custom location | ❌ | ❌ | ❌ | ✅ | ✅ |
| Desktop icon | ❌ | ❌ | ❌ | ✅ | ✅ |
| Start Menu | ❌ | ❌ | ❌ | ✅ | ✅ |
| Add/Remove Programs | ❌ | ❌ | ❌ | ✅ | ✅ |
| Group Policy | ❌ | ❌ | ❌ | ❌ | ✅ |
| Can be signed | ❌ | ❌ | ✅ | ✅ | ✅ |

---

## 🐛 Troubleshooting

### Window closes immediately
**Solution:** Use `install.bat` instead of `install.ps1`

### "Execution policy" error
**Solution:** Run PowerShell as admin:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### "cl.exe not found" (Visual Studio)
**Solution:** Use "Developer Command Prompt for VS" instead of regular command prompt

### "ISCC.exe not found" (Inno Setup)
**Solution:** Install Inno Setup from https://jrsoftware.org/isdl.php

### "candle.exe not found" (MSI)
**Solution:** Install WiX Toolset from https://wixtoolset.org/releases/

---

## 📚 Documentation

- **HOW_TO_INSTALL.md** - Simple installation guide
- **BUILD_WITH_VISUAL_STUDIO.md** - Visual Studio compilation guide
- **BUILD_INSTALLERS.md** - Build Inno Setup and MSI
- **WHAT_IS_WHAT.md** - Understand all files
- **INSTALLER_EXPLAINED.md** - Detailed explanation

---

## 🎯 Quick Start

**Just want to install J?**

```cmd
cd j-lang\installers
install.bat
```

**Want to build a distributable installer?**

See `BUILD_WITH_VISUAL_STUDIO.md` or `BUILD_INSTALLERS.md`

---

**Version:** 0.1.0  
**Last Updated:** February 13, 2026

**Choose the method that works best for you!** 🚀
