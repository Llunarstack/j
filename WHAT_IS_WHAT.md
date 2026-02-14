# J Language - What is What?

Visual guide to understand all the files.

---

## 🎯 The Main Program

```
j.exe
├─ Location: j-lang/dist/j-windows-x86_64.exe
├─ What: The J programming language compiler/interpreter
├─ Size: 1.56 MB
└─ Use: j --version, j repl, j run program.j
```

**This is what you actually use to write and run J programs!**

---

## 📦 The Installers (They install j.exe)

### 1. PowerShell Script Installer

```
install.ps1
├─ Location: j-lang/installers/install.ps1
├─ What: Script that installs J automatically
├─ Size: 6 KB
├─ Requires: Nothing (PowerShell is built into Windows)
└─ Use: .\install.ps1
```

**What it does:**
1. Copies j.exe to %LOCALAPPDATA%\J\bin\
2. Adds J to PATH
3. Copies J_lang_logo.ico
4. Sets up file association (.j files → J icon)
5. Copies examples

**After running:** You have j.exe installed and can use `j` command

---

### 2. EXE Installer (Inno Setup)

```
j-lang-setup.iss (source file)
├─ Location: j-lang/installers/j-lang-setup.iss
├─ What: Instructions for building an EXE installer
├─ Size: 12 KB
└─ Build: iscc j-lang-setup.iss

         ↓ (builds into)

j-lang-0.1.0-windows-setup.exe (installer)
├─ Location: j-lang/dist/installers/j-lang-0.1.0-windows-setup.exe
├─ What: Professional Windows installer with GUI wizard
├─ Size: ~2 MB (includes j.exe)
└─ Use: Double-click and follow wizard
```

**What it does:** Same as install.ps1 but with a nice GUI

**Requires to build:** Inno Setup (https://jrsoftware.org/isdl.php)

---

### 3. MSI Installer (WiX)

```
j-lang.wxs (source file)
├─ Location: j-lang/installers/j-lang.wxs
├─ What: Instructions for building an MSI installer
├─ Size: 8 KB
└─ Build: .\build-msi.ps1

         ↓ (builds into)

j-lang-0.1.0-windows-x64.msi (installer)
├─ Location: j-lang/dist/installers/j-lang-0.1.0-windows-x64.msi
├─ What: Professional Windows MSI installer
├─ Size: ~2 MB (includes j.exe)
└─ Use: Double-click or msiexec /i j-lang-0.1.0-windows-x64.msi
```

**What it does:** Same as above, uses Windows Installer technology

**Requires to build:** WiX Toolset (https://wixtoolset.org/releases/)

---

## 🎨 The Icon

```
J_lang_logo.ico
├─ Location: j-lang/J_lang_logo.ico
├─ What: The J language logo icon
├─ Size: ~50 KB
└─ Used by: All installers to set icon for .j files
```

**What it does:**
- Shows on .j files in Windows Explorer
- Shows on shortcuts
- Shows in Start Menu

**Already configured in all installers!**

---

## 📊 Visual Flow

```
┌─────────────────────────────────────────────────────────┐
│                    BUILD PROCESS                         │
└─────────────────────────────────────────────────────────┘

Source Code (Rust)
      ↓
   cargo build --release
      ↓
   j.exe (1.56 MB)
   ├─ The actual J language program
   └─ Located in: j-lang/dist/j-windows-x86_64.exe


┌─────────────────────────────────────────────────────────┐
│                  INSTALLER OPTIONS                       │
└─────────────────────────────────────────────────────────┘

Option 1: PowerShell Script (Easiest)
   install.ps1
      ↓
   Run: .\install.ps1
      ↓
   J is installed!

Option 2: Build EXE Installer
   j-lang-setup.iss
      ↓
   Build: iscc j-lang-setup.iss
      ↓
   j-lang-0.1.0-windows-setup.exe
      ↓
   Run: Double-click
      ↓
   J is installed!

Option 3: Build MSI Installer
   j-lang.wxs
      ↓
   Build: .\build-msi.ps1
      ↓
   j-lang-0.1.0-windows-x64.msi
      ↓
   Run: Double-click
      ↓
   J is installed!


┌─────────────────────────────────────────────────────────┐
│                  AFTER INSTALLATION                      │
└─────────────────────────────────────────────────────────┘

%LOCALAPPDATA%\J\
├── bin\
│   └── j.exe ← The J language program
├── examples\
│   ├── basic.j
│   └── ...
└── J_lang_logo.ico ← The icon

PATH updated → You can run: j --version
Registry updated → .j files show J icon
```

---

## 🤔 Common Questions

### Q: What's the difference between .ps1 and .exe?

**A:**
- `.ps1` = Script installer (runs immediately, no build needed)
- `.exe` = Built installer (needs Inno Setup to build, has GUI)
- Both install the same thing: j.exe

### Q: Which installer should I use?

**A:**
- **For yourself:** Use `install.ps1` (easiest, works now)
- **For distribution:** Build `.exe` or `.msi` (professional, GUI)

### Q: Where is j.exe?

**A:**
- Before install: `j-lang/dist/j-windows-x86_64.exe`
- After install: `%LOCALAPPDATA%\J\bin\j.exe`

### Q: Do .j files use the icon?

**A:** Yes! All installers automatically configure this.

### Q: How do I build the EXE installer?

**A:**
```powershell
# Install Inno Setup first
# Then:
cd j-lang\installers
iscc j-lang-setup.iss
```

### Q: How do I build the MSI installer?

**A:**
```powershell
# Install WiX Toolset first
# Then:
cd j-lang\installers
.\build-msi.ps1
```

---

## 📝 File Summary

| File | Type | Purpose | Size |
|------|------|---------|------|
| `j.exe` | Program | The J language | 1.56 MB |
| `install.ps1` | Installer | Installs J (script) | 6 KB |
| `j-lang-setup.iss` | Source | Build EXE installer | 12 KB |
| `j-lang-setup.exe` | Installer | Installs J (GUI) | ~2 MB |
| `j-lang.wxs` | Source | Build MSI installer | 8 KB |
| `j-lang-setup.msi` | Installer | Installs J (MSI) | ~2 MB |
| `J_lang_logo.ico` | Icon | J logo for .j files | 50 KB |

---

## 🚀 Quick Start

**Just want to use J? Run this:**

```powershell
cd j-lang\installers
.\install.ps1
```

**Done!** Now you can use J:

```powershell
j --version
j repl
j run myprogram.j
```

**All .j files will have the J icon!**

---

**Version:** 0.1.0  
**Last Updated:** February 13, 2026
