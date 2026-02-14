# J Language - Start Here

Welcome! This guide will help you install or build J Language.

---

## 🎯 What Do You Want to Do?

### Option A: Just Install J (Easiest)

**No compilation needed! Works immediately!**

1. Open File Explorer
2. Go to: `j-lang\installers\`
3. **Double-click:** `install.bat`
4. Press any key when done
5. Open new terminal and run: `j --version`

**Done!** J is installed with icon configured for .j files.

---

### Option B: Compile a Native Installer (Advanced)

**Creates a standalone .exe installer**

1. Open File Explorer
2. Go to: `j-lang\installers\`
3. **Double-click:** `build-installer-auto.bat`
4. Wait for compilation
5. Get: `j-installer.exe`
6. Run: `j-installer.exe`

**Requirements:** Visual Studio with C++ Desktop Development

**Don't have Visual Studio?**
- Download: https://visualstudio.microsoft.com/downloads/
- Choose "Community" (free)
- Install "Desktop development with C++"

---

## 📚 Documentation

### For Users
- **HOW_TO_INSTALL.md** - Simple installation guide
- **GET_STARTED.md** - Complete tutorial
- **INSTALL.md** - Quick reference

### For Developers
- **COMPILE_INSTALLER.md** - How to compile installer
- **BUILD_WITH_VISUAL_STUDIO.md** - Detailed VS guide
- **INSTALLER_OPTIONS.md** - All installation methods
- **WHAT_IS_WHAT.md** - Understand all files

---

## 🚀 Quick Commands

### Install J
```cmd
cd j-lang\installers
install.bat
```

### Compile Installer
```cmd
cd j-lang\installers
build-installer-auto.bat
```

### Verify Installation
```cmd
j --version
j repl
```

---

## 🎨 Features

All installers provide:
- ✅ j.exe (The J compiler/interpreter)
- ✅ PATH configuration
- ✅ J icon for .j files
- ✅ File associations
- ✅ Examples
- ✅ Uninstaller

---

## 🐛 Troubleshooting

### "Compiler not found"
**Solution:** Use `build-installer-auto.bat` or install Visual Studio

### "Window closes immediately"
**Solution:** Use `install.bat` instead of `install.ps1`

### "j is not recognized"
**Solution:** Restart terminal or run:
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','User')
```

---

## 📊 File Overview

| File | Purpose | Build? |
|------|---------|--------|
| install.bat | Install J | No |
| install.ps1 | Install J | No |
| build-installer-auto.bat | Compile installer | Yes |
| installer.cpp | Installer source | - |
| j-installer.exe | Compiled installer | (output) |

---

## 🎯 Recommendations

**For yourself:**
- Use `install.bat` (easiest, works now)

**For distribution:**
- Compile with `build-installer-auto.bat`
- Or use Inno Setup (see `BUILD_INSTALLERS.md`)

---

## 💡 Next Steps

After installation:

1. **Verify:** `j --version`
2. **Try REPL:** `j repl`
3. **Run example:** `j run examples\basic.j`
4. **Read tutorial:** `GET_STARTED.md`
5. **Check docs:** `docs\` folder

---

## 🆘 Need Help?

- Read: `HOW_TO_INSTALL.md`
- Check: `INSTALLER_OPTIONS.md`
- See: `docs\` folder

---

**Version:** 0.1.0  
**Last Updated:** February 13, 2026

**Welcome to J Language!** 🚀

---

## 🎉 TL;DR

**Just want to install J?**

Double-click: `j-lang\installers\install.bat`

**That's it!**
