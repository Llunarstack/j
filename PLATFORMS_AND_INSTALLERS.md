# J Language - Platforms & Installers

Quick reference for all supported platforms and installation methods.

---

## 🎯 Supported Platforms

### Windows
- ✅ **x64** (64-bit) - Tested and working
- ✅ **x86** (32-bit) - Built and ready
- ⏳ **ARM64** - Ready (needs ARM64 build tools)

### Linux
- ⏳ **x64** - Ready (needs native build)
- ⏳ **x86** - Ready (needs native build)
- ⏳ **ARM64** - Ready (needs native build)
- ⏳ **ARMv7** - Ready (needs native build)

### macOS
- ⏳ **Intel (x64)** - Ready (needs native build)
- ⏳ **Apple Silicon (ARM64)** - Ready (needs native build)

---

## 📦 Installation Methods

### 1. Script Installers (Easiest)

**Windows:**
```powershell
cd j-lang\installers
.\install.ps1
```

**Linux/macOS:**
```bash
cd j-lang/installers
chmod +x install.sh && ./install.sh
```

### 2. MSI Installer (Windows Professional)

**Build:**
```powershell
cd j-lang\installers
.\build-msi.ps1
```

**Install:**
```powershell
msiexec /i dist\installers\j-lang-0.1.0-windows-x64.msi
```

### 3. Inno Setup (Windows GUI)

**Build:**
```powershell
cd j-lang\installers
iscc j-lang-setup.iss
```

**Install:**
Double-click the generated `.exe` file

### 4. Manual Installation

Download executable for your platform and add to PATH.

---

## 🔨 Building from Source

**Simple build:**
```bash
cd j-lang
cargo build --release
```

**Build all platforms:**
```powershell
cd j-lang\installers
.\build-all-executables.ps1
```

**Build specific platform:**
```bash
cargo build --release --target <target-triple>
```

---

## 📊 Quick Status

| Platform | Status | Installer | Notes |
|----------|--------|-----------|-------|
| Windows x64 | ✅ Ready | ✅ All types | Fully tested |
| Windows x86 | ✅ Ready | ✅ All types | Built |
| Windows ARM64 | ⏳ Pending | ✅ Ready | Needs ARM64 tools |
| Linux x64 | ⏳ Pending | ✅ Ready | Use CI/CD |
| Linux ARM64 | ⏳ Pending | ✅ Ready | Use CI/CD |
| macOS Intel | ⏳ Pending | ✅ Ready | Use CI/CD |
| macOS M1/M2 | ⏳ Pending | ✅ Ready | Use CI/CD |

---

## 📚 Documentation

- **Complete Guide**: `docs/ALL_PLATFORMS_GUIDE.md`
- **Installation**: `j-lang/installers/README.md`
- **Getting Started**: `GET_STARTED.md`
- **Build Instructions**: `docs/BUILD_INSTRUCTIONS.md`

---

## 🚀 For Distribution

**Use GitHub Actions** to build all platforms automatically:

```bash
git tag v0.1.0
git push origin v0.1.0
```

This will build and release for all 9 platform/architecture combinations.

---

**Version**: 0.1.0  
**Last Updated**: February 13, 2026
