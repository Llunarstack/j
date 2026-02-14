# J Language - All Platforms Guide

**Date**: February 13, 2026  
**Version**: 0.1.0

Complete guide for building and installing J on all supported platforms.

---

## 📦 Supported Platforms

### Windows
- ✅ x86_64 (64-bit Intel/AMD) - **TESTED**
- ✅ i686 (32-bit Intel/AMD) - **BUILT**
- ⏳ aarch64 (ARM64) - **PLANNED**

### Linux
- ⏳ x86_64 (64-bit Intel/AMD)
- ⏳ i686 (32-bit Intel/AMD)
- ⏳ aarch64 (ARM64)
- ⏳ armv7 (ARMv7)

### macOS
- ⏳ x86_64 (Intel)
- ⏳ aarch64 (Apple Silicon M1/M2/M3)

---

## 🚀 Installation Methods

### Method 1: Script Installers (Recommended)

**Windows PowerShell:**
```powershell
cd j-lang\installers
.\install.ps1
```

**Linux/macOS Bash:**
```bash
cd j-lang/installers
chmod +x install.sh
./install.sh
```

### Method 2: MSI Installer (Windows)

**Build MSI:**
```powershell
# Requires WiX Toolset: https://wixtoolset.org/releases/
cd j-lang\installers
.\build-msi.ps1
```

**Install MSI:**
```powershell
msiexec /i dist\installers\j-lang-0.1.0-windows-x64.msi
```

Or double-click the MSI file.

### Method 3: Inno Setup Installer (Windows)

**Build Installer:**
```powershell
# Requires Inno Setup: https://jrsoftware.org/isdl.php
cd j-lang\installers
iscc j-lang-setup.iss
```

**Install:**
Double-click `dist\installers\j-lang-0.1.0-windows-setup.exe`

---

## 🔨 Building from Source

### Prerequisites

**All Platforms:**
- Rust 1.70+ (install from https://rustup.rs/)
- Cargo (comes with Rust)

**Linux (for cross-compilation):**
```bash
# For ARM64
sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu

# For ARMv7
sudo apt-get install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf

# For i686
sudo apt-get install gcc-multilib g++-multilib
```

**Windows (for ARM64):**
- Visual Studio 2019+ with ARM64 build tools

### Build Commands

**Windows x64:**
```powershell
cd j-lang
cargo build --release --target x86_64-pc-windows-msvc
```

**Windows x86:**
```powershell
cargo build --release --target i686-pc-windows-msvc
```

**Windows ARM64:**
```powershell
cargo build --release --target aarch64-pc-windows-msvc
```

**Linux x64:**
```bash
cargo build --release --target x86_64-unknown-linux-gnu
```

**Linux i686:**
```bash
cargo build --release --target i686-unknown-linux-gnu
```

**Linux ARM64:**
```bash
cargo build --release --target aarch64-unknown-linux-gnu
```

**Linux ARMv7:**
```bash
cargo build --release --target armv7-unknown-linux-gnueabihf
```

**macOS Intel:**
```bash
cargo build --release --target x86_64-apple-darwin
```

**macOS Apple Silicon:**
```bash
cargo build --release --target aarch64-apple-darwin
```

### Build All Platforms (Windows)

```powershell
cd j-lang\installers
.\build-all-executables.ps1
```

This will attempt to build for all platforms. Cross-compilation may fail without proper toolchains.

---

## 📍 Installation Locations

### Windows (Script/MSI)
```
%LOCALAPPDATA%\J\
├── bin\j.exe
├── examples\
└── J_lang_logo.ico
```

### Linux/macOS (Script)
```
~/.j/
├── bin/j
└── examples/
```

---

## 🎯 Executable Naming Convention

| Platform | Architecture | Filename |
|----------|-------------|----------|
| Windows | x64 | `j-windows-x86_64.exe` |
| Windows | x86 | `j-windows-i686.exe` |
| Windows | ARM64 | `j-windows-aarch64.exe` |
| Linux | x64 | `j-linux-x86_64` |
| Linux | x86 | `j-linux-i686` |
| Linux | ARM64 | `j-linux-aarch64` |
| Linux | ARMv7 | `j-linux-armv7` |
| macOS | Intel | `j-macos-x86_64` |
| macOS | Apple Silicon | `j-macos-aarch64` |

---

## 🔧 Installer Types

### 1. PowerShell Script (Windows)

**File:** `install.ps1`

**Features:**
- ✅ Auto-detects architecture
- ✅ Adds to PATH
- ✅ Creates file associations
- ✅ No admin required
- ✅ Uninstaller included

**Usage:**
```powershell
.\install.ps1
.\install.ps1 -Uninstall  # To uninstall
```

### 2. Bash Script (Linux/macOS)

**File:** `install.sh`

**Features:**
- ✅ Auto-detects OS and architecture
- ✅ Adds to PATH
- ✅ Configures shell (bash/zsh/fish)
- ✅ No admin required
- ✅ Uninstaller included

**Usage:**
```bash
./install.sh
./install.sh --uninstall  # To uninstall
```

### 3. MSI Installer (Windows)

**File:** `j-lang-0.1.0-windows-x64.msi`

**Features:**
- ✅ Professional Windows installer
- ✅ GUI wizard
- ✅ Custom install location
- ✅ Add/Remove Programs integration
- ✅ Automatic PATH configuration
- ✅ File associations
- ✅ Start Menu shortcuts

**Build Requirements:**
- WiX Toolset 3.11+

**Build:**
```powershell
cd j-lang\installers
.\build-msi.ps1
```

### 4. Inno Setup Installer (Windows)

**File:** `j-lang-0.1.0-windows-setup.exe`

**Features:**
- ✅ Professional GUI installer
- ✅ Multi-architecture support
- ✅ Custom install location
- ✅ Optional desktop icon
- ✅ Optional PATH addition
- ✅ File associations
- ✅ Modern wizard interface

**Build Requirements:**
- Inno Setup 6.x

**Build:**
```powershell
cd j-lang\installers
iscc j-lang-setup.iss
```

---

## 🤖 CI/CD with GitHub Actions

The project includes a GitHub Actions workflow that automatically builds for all platforms.

**File:** `.github/workflows/build-release.yml`

**Triggers:**
- Push to tags (v*)
- Manual workflow dispatch

**Builds:**
- Windows: x64, x86, ARM64
- Linux: x64, x86, ARM64, ARMv7
- macOS: Intel, Apple Silicon

**To create a release:**
```bash
git tag v0.1.0
git push origin v0.1.0
```

GitHub Actions will automatically:
1. Build for all platforms
2. Create release artifacts
3. Generate checksums
4. Create GitHub release

---

## 📊 Platform Status

| Platform | Arch | Build | Installer | Status |
|----------|------|-------|-----------|--------|
| Windows | x64 | ✅ | ✅ | **TESTED** |
| Windows | x86 | ✅ | ✅ | **BUILT** |
| Windows | ARM64 | ⏳ | ✅ | Needs ARM64 tools |
| Linux | x64 | ⏳ | ✅ | Needs native build |
| Linux | x86 | ⏳ | ✅ | Needs native build |
| Linux | ARM64 | ⏳ | ✅ | Needs native build |
| Linux | ARMv7 | ⏳ | ✅ | Needs native build |
| macOS | Intel | ⏳ | ✅ | Needs native build |
| macOS | M1/M2 | ⏳ | ✅ | Needs native build |

**Legend:**
- ✅ = Complete and tested
- ⏳ = Ready but needs building
- ❌ = Not supported

---

## 🐛 Troubleshooting

### Cross-Compilation Issues

**Problem:** Build fails with "linker not found"

**Solution:** Cross-compilation requires native toolchains. Options:
1. Build on native platform
2. Use GitHub Actions (recommended)
3. Install cross-compilation tools
4. Use Docker with cross-compilation support

### Windows ARM64 Build

**Problem:** ARM64 build fails on Windows

**Solution:** Install Visual Studio with ARM64 build tools:
1. Download Visual Studio 2019+
2. Select "Desktop development with C++"
3. Select "MSVC ARM64 build tools"
4. Rebuild

### Linux Cross-Compilation

**Problem:** Linux ARM builds fail

**Solution:** Install cross-compilation tools:
```bash
# For ARM64
sudo apt-get install gcc-aarch64-linux-gnu

# For ARMv7
sudo apt-get install gcc-arm-linux-gnueabihf

# For i686
sudo apt-get install gcc-multilib
```

---

## 📦 Distribution

### For GitHub Releases

1. Build all platforms (use GitHub Actions)
2. Create release tag
3. Upload artifacts:
   - All executables
   - MSI installer
   - Inno Setup installer
   - Script installers
   - Checksums

### For Website

Host installers and provide one-line install:

**Windows:**
```powershell
irm https://j-lang.org/install.ps1 | iex
```

**Linux/macOS:**
```bash
curl -fsSL https://j-lang.org/install.sh | bash
```

### For Package Managers

**Future work:**
- Chocolatey (Windows)
- Homebrew (macOS)
- apt/deb (Debian/Ubuntu)
- yum/rpm (RedHat/Fedora)
- AUR (Arch Linux)
- Snap (Linux)
- Flatpak (Linux)

---

## 🎓 Best Practices

### For Users

1. **Use script installers** for simplest installation
2. **Use MSI/Inno Setup** for professional Windows installation
3. **Verify installation** with `j --version`
4. **Check PATH** if command not found

### For Developers

1. **Build on native platform** when possible
2. **Use GitHub Actions** for multi-platform builds
3. **Test on target platform** before release
4. **Include checksums** with releases
5. **Document platform requirements**

---

## 📝 Summary

J Language supports:
- **3 operating systems** (Windows, Linux, macOS)
- **9 architectures** (x64, x86, ARM64, ARMv7)
- **4 installer types** (Script, MSI, Inno Setup, Manual)
- **Automatic CI/CD** (GitHub Actions)

**Current Status:**
- ✅ Windows x64/x86 fully working
- ✅ All installers ready
- ⏳ Other platforms need native builds
- ✅ CI/CD configured

---

**Last Updated**: February 13, 2026  
**Version**: 0.1.0

---

**For more information:**
- Installation Guide: `j-lang/installers/README.md`
- Build Instructions: `docs/BUILD_INSTRUCTIONS.md`
- Getting Started: `GET_STARTED.md`
