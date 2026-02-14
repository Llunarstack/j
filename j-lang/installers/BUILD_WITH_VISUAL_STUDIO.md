# Build J Installer with Visual Studio

This guide shows you how to compile the J installer into a native Windows executable using Visual Studio.

---

## 📋 Prerequisites

- Visual Studio 2019 or later (Community, Professional, or Enterprise)
- C++ Desktop Development workload installed

---

## 🔨 Method 1: Using Developer Command Prompt (Easiest)

### Step 1: Open Developer Command Prompt

**Option A: From Start Menu**
1. Press Windows key
2. Type "Developer Command Prompt"
3. Click "Developer Command Prompt for VS 2022" (or your version)

**Option B: From Visual Studio**
1. Open Visual Studio
2. Go to: Tools → Command Line → Developer Command Prompt

### Step 2: Navigate to Installers Directory

```cmd
cd C:\Users\YourUsername\path\to\j\j-lang\installers
```

### Step 3: Build the Installer

```cmd
build-installer-exe.bat
```

### Step 4: Run the Installer

```cmd
j-installer.exe
```

---

## 🔨 Method 2: Manual Compilation

### Step 1: Open Developer Command Prompt

(Same as Method 1)

### Step 2: Navigate and Compile

```cmd
cd j-lang\installers

cl.exe /EHsc /std:c++17 /O2 /Fe:j-installer.exe installer.cpp shell32.lib advapi32.lib user32.lib
```

### Step 3: Run

```cmd
j-installer.exe
```

---

## 🔨 Method 3: Using Visual Studio IDE

### Step 1: Create New Project

1. Open Visual Studio
2. File → New → Project
3. Select "Console App" (C++)
4. Name: "JInstaller"
5. Click Create

### Step 2: Replace Code

1. Delete the default code in the .cpp file
2. Copy all content from `installer.cpp`
3. Paste into your project

### Step 3: Configure Project

1. Right-click project → Properties
2. Configuration Properties → C/C++ → Language
3. Set "C++ Language Standard" to "ISO C++17"
4. Click OK

### Step 4: Add Libraries

1. Right-click project → Properties
2. Configuration Properties → Linker → Input
3. Additional Dependencies: Add `shell32.lib;advapi32.lib;user32.lib`
4. Click OK

### Step 5: Build

1. Build → Build Solution (or press F7)
2. Find output in: `x64\Release\JInstaller.exe`

### Step 6: Copy and Run

1. Copy `JInstaller.exe` to `j-lang\installers\`
2. Rename to `j-installer.exe`
3. Double-click to run

---

## ✅ What You Get

**Output:** `j-installer.exe` (~50-100 KB)

**What it does:**
- ✅ Native Windows executable (no dependencies)
- ✅ Installs j.exe
- ✅ Adds to PATH
- ✅ Sets up file associations
- ✅ Configures .j file icon
- ✅ Copies examples

---

## 🚀 Using the Installer

After building, you have a standalone executable:

```cmd
j-installer.exe
```

Follow the on-screen instructions!

---

## 📊 Comparison

| Method | Difficulty | Output |
|--------|-----------|--------|
| Developer Command Prompt | Easy | j-installer.exe |
| Manual Compilation | Medium | j-installer.exe |
| Visual Studio IDE | Medium | JInstaller.exe |
| PowerShell Script | Easiest | (no build needed) |

---

## 🐛 Troubleshooting

### "cl.exe is not recognized"

**Solution:** You're not in Developer Command Prompt. Open it from Start Menu.

### "Cannot open include file"

**Solution:** Install "Desktop development with C++" workload in Visual Studio Installer.

### "LNK2019: unresolved external symbol"

**Solution:** Add the required libraries:
```cmd
shell32.lib advapi32.lib user32.lib
```

### Build succeeds but installer doesn't work

**Solution:** Make sure you're in the `j-lang\installers\` directory when running the installer.

---

## 📝 Files

- `installer.cpp` - C++ source code
- `build-installer-exe.bat` - Build script
- `j-installer.exe` - Compiled installer (after building)

---

## 🎯 Why Compile?

**Advantages of compiled installer:**
- ✅ Single .exe file (no dependencies)
- ✅ Faster execution
- ✅ Professional appearance
- ✅ Can be digitally signed
- ✅ Works without PowerShell

**When to use PowerShell script instead:**
- ✅ Don't have Visual Studio
- ✅ Want to modify installer easily
- ✅ Quick testing

---

## 📚 Next Steps

After building the installer:

1. Test it: `j-installer.exe`
2. Distribute it to users
3. Optional: Sign it with a code signing certificate

---

**Version:** 0.1.0  
**Last Updated:** February 13, 2026

**Happy building!** 🚀
