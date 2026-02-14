# How to Compile the J Installer

Quick guide to compile the installer with Visual Studio.

---

## 🚀 Super Easy Method (Recommended)

### Just double-click this file:

```
build-installer-auto.bat
```

This will:
1. ✅ Auto-detect Visual Studio
2. ✅ Set up the environment
3. ✅ Compile the installer
4. ✅ Create `j-installer.exe`
5. ✅ Optionally run it

**That's it!**

---

## 🔧 Manual Method (If Auto Doesn't Work)

### Step 1: Open Developer Command Prompt

**Windows 11/10:**
1. Press Windows key
2. Type: `developer command`
3. Click: **"Developer Command Prompt for VS 2022"**

**Or from Start Menu:**
- Start → Visual Studio 2022 → Developer Command Prompt for VS 2022

### Step 2: Navigate to Installers

```cmd
cd C:\Users\YourUsername\path\to\j\j-lang\installers
```

### Step 3: Build

```cmd
build-installer-exe.bat
```

### Step 4: Run

```cmd
j-installer.exe
```

---

## 📋 What You Need

- ✅ Visual Studio 2019 or later
- ✅ "Desktop development with C++" workload

**Don't have Visual Studio?**

Download from: https://visualstudio.microsoft.com/downloads/

Choose "Community" (free) and install "Desktop development with C++"

---

## 🎯 What You Get

**Output:** `j-installer.exe` (~50-100 KB)

**What it does:**
- Installs j.exe
- Adds to PATH
- Sets up .j file icon
- Creates file associations
- Copies examples

---

## 🐛 Troubleshooting

### "Visual Studio not found"

**Solution 1:** Use `build-installer-auto.bat` (auto-detects VS)

**Solution 2:** Install Visual Studio from https://visualstudio.microsoft.com/downloads/

**Solution 3:** Open "Developer Command Prompt for VS" manually

### "cl.exe is not recognized"

**Solution:** You need to install the C++ workload:
1. Open Visual Studio Installer
2. Click "Modify"
3. Check "Desktop development with C++"
4. Click "Modify" to install

### "Cannot open include file"

**Solution:** Same as above - install C++ workload

---

## 💡 Alternative: Use PowerShell Installer

Don't want to compile? Just use the PowerShell installer:

```powershell
.\install.ps1
```

Or double-click: `install.bat`

Both work immediately without compiling!

---

## 📊 Comparison

| Method | Compile? | Output | Best For |
|--------|----------|--------|----------|
| build-installer-auto.bat | Yes | j-installer.exe | Distribution |
| build-installer-exe.bat | Yes | j-installer.exe | Manual build |
| install.bat | No | N/A | Quick install |
| install.ps1 | No | N/A | Quick install |

---

## 🎓 Why Compile?

**Compiled installer advantages:**
- ✅ Single .exe file
- ✅ No dependencies
- ✅ Faster execution
- ✅ Professional appearance
- ✅ Can be digitally signed

**PowerShell installer advantages:**
- ✅ No build needed
- ✅ Works immediately
- ✅ Easy to modify
- ✅ No Visual Studio required

---

## 🚀 Quick Start

**Want to compile?**
```cmd
build-installer-auto.bat
```

**Just want to install J?**
```cmd
install.bat
```

---

**Version:** 0.1.0  
**Last Updated:** February 13, 2026

**Choose what works best for you!** 🎯
