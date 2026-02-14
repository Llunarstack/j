# J Language - Installer System

Complete cross-platform installer system for the J Programming Language.

## 🚀 Quick Install

### Windows

**PowerShell (Recommended):**
```powershell
irm https://j-lang.org/install.ps1 | iex
```

**Or download and run:**
```powershell
.\install.ps1
```

**Or use the GUI installer:**
- Download `j-lang-0.1.0-windows-setup.exe`
- Double-click to install

### Linux/macOS

**One-line install:**
```bash
curl -fsSL https://j-lang.org/install.sh | bash
```

**Or download and run:**
```bash
chmod +x install.sh
./install.sh
```

### Package Managers

**Homebrew (macOS/Linux):**
```bash
brew install j-lang
```

**Debian/Ubuntu:**
```bash
sudo dpkg -i j-lang_0.1.0_amd64.deb
```

**Fedora/RHEL/CentOS:**
```bash
sudo rpm -i j-lang-0.1.0-1.x86_64.rpm
```

---

## 📦 Supported Platforms

### Operating Systems
- ✅ Windows 7, 8, 10, 11
- ✅ Windows Server 2012+
- ✅ Ubuntu 18.04+
- ✅ Debian 9+
- ✅ Fedora 30+
- ✅ RHEL/CentOS 7+
- ✅ macOS 10.13+ (High Sierra and later)
- ✅ FreeBSD 12+

### Architectures
- ✅ x86_64 (64-bit Intel/AMD)
- ✅ i686 (32-bit Intel/AMD)
- ✅ aarch64 (64-bit ARM - Apple Silicon, Raspberry Pi 4)
- ✅ armv7 (32-bit ARM - Raspberry Pi 3)
- ✅ arm (32-bit ARM - Raspberry Pi 2)

---

## 🛠️ Building Installers

### Prerequisites

**All Platforms:**
- Rust toolchain (1.70+)
- Git

**Windows:**
- Visual Studio Build Tools (for MSVC targets)
- [Inno Setup](https://jrsoftware.org/isinfo.php) (for GUI installer)

**Linux:**
- `dpkg-deb` (for .deb packages)
- `rpmbuild` (for .rpm packages)
- `cross` (for cross-compilation)

**macOS:**
- Xcode Command Line Tools

### Build All Binaries

**Windows:**
```powershell
.\build-all-platforms.ps1
```

**Linux/macOS:**
```bash
./build-all-platforms.sh
```

This creates binaries in `dist/` for all supported platforms.

### Build Platform-Specific Installers

**Windows GUI Installer:**
```powershell
# Requires Inno Setup installed
iscc installer-windows.iss
```

**Debian Package:**
```bash
./build-deb.sh
```

**RPM Package:**
```bash
./build-rpm.sh
```

**macOS Package:**
```bash
./build-macos-pkg.sh
```

---

## 📋 Installer Features

### Windows Installer
- ✅ GUI wizard with modern interface
- ✅ Automatic PATH configuration
- ✅ File association (.j files)
- ✅ Desktop shortcuts
- ✅ Start menu entries
- ✅ Uninstaller
- ✅ Multi-language support
- ✅ Architecture detection (x86/x64/ARM64)

### Linux/macOS Installer
- ✅ Automatic platform detection
- ✅ Shell integration (bash/zsh/fish)
- ✅ PATH configuration
- ✅ Examples installation
- ✅ Uninstall support
- ✅ Colored output
- ✅ Progress indicators

### Package Managers
- ✅ Debian/Ubuntu (.deb)
- ✅ Fedora/RHEL (.rpm)
- ✅ Homebrew (macOS/Linux)
- ✅ Desktop integration
- ✅ Icon installation
- ✅ Automatic updates

---

## 🎨 Branding

The installer uses the official J Language logo (`J_lang_logo.ico`):
- Windows: Icon for executable and file associations
- Linux: Desktop entry icon
- macOS: Application icon

---

## 📁 Installation Locations

### Windows
- **Binary:** `%LOCALAPPDATA%\J\bin\j.exe`
- **Examples:** `%LOCALAPPDATA%\J\examples\`
- **Stdlib:** `%LOCALAPPDATA%\J\stdlib\`

### Linux/macOS (Script)
- **Binary:** `~/.j/bin/j`
- **Examples:** `~/.j/examples/`
- **Stdlib:** `~/.j/stdlib/`

### Linux (Package Manager)
- **Binary:** `/usr/bin/j`
- **Examples:** `/usr/share/j/examples/`
- **Stdlib:** `/usr/share/j/stdlib/`

### macOS (Homebrew)
- **Binary:** `/usr/local/bin/j`
- **Examples:** `/usr/local/share/j/examples/`
- **Stdlib:** `/usr/local/share/j/stdlib/`

---

## 🔧 Advanced Usage

### Custom Installation Directory

**Windows:**
```powershell
.\install.ps1 -InstallDir "C:\MyApps\J"
```

**Linux/macOS:**
```bash
J_INSTALL_DIR=/opt/j ./install.sh
```

### Uninstall

**Windows:**
```powershell
.\install.ps1 -Uninstall
```

**Linux/macOS:**
```bash
./install.sh --uninstall
```

**Package Managers:**
```bash
# Debian/Ubuntu
sudo apt remove j-lang

# Fedora/RHEL
sudo dnf remove j-lang

# Homebrew
brew uninstall j-lang
```

---

## 🧪 Testing Installers

### Test Windows Installer
```powershell
# Build
.\build-all-platforms.ps1

# Test install
.\install.ps1

# Verify
j --version
j repl

# Uninstall
.\install.ps1 -Uninstall
```

### Test Linux Installer
```bash
# Build
./build-all-platforms.sh

# Test install
./install.sh

# Verify
j --version
j repl

# Uninstall
./install.sh --uninstall
```

### Test Package
```bash
# Debian
./build-deb.sh
sudo dpkg -i dist/installers/j-lang_0.1.0_amd64.deb
j --version

# RPM
./build-rpm.sh
sudo rpm -i dist/installers/j-lang-0.1.0-1.x86_64.rpm
j --version
```

---

## 📊 Build Matrix

| Platform | Architecture | Binary | Installer | Status |
|----------|-------------|--------|-----------|--------|
| Windows | x86_64 | ✅ | ✅ .exe, .msi | Ready |
| Windows | i686 | ✅ | ✅ .exe, .msi | Ready |
| Windows | aarch64 | ✅ | ✅ .exe, .msi | Ready |
| Linux | x86_64 | ✅ | ✅ .deb, .rpm | Ready |
| Linux | i686 | ✅ | ✅ .deb, .rpm | Ready |
| Linux | aarch64 | ✅ | ✅ .deb, .rpm | Ready |
| Linux | armv7 | ✅ | ✅ .deb, .rpm | Ready |
| Linux | arm | ✅ | ✅ .deb, .rpm | Ready |
| macOS | x86_64 | ✅ | ✅ .pkg, brew | Ready |
| macOS | aarch64 | ✅ | ✅ .pkg, brew | Ready |
| FreeBSD | x86_64 | ✅ | 🚧 Script only | Partial |

---

## 🔐 Security

### Checksums
All binaries include SHA256 checksums in `dist/checksums.txt`:
```bash
# Verify download
sha256sum -c checksums.txt
```

### Code Signing

**Windows:**
```powershell
# Sign executable (requires certificate)
signtool sign /f certificate.pfx /p password /t http://timestamp.digicert.com dist/j-windows-x86_64.exe
```

**macOS:**
```bash
# Sign and notarize (requires Apple Developer account)
codesign --sign "Developer ID Application" dist/j-macos-x86_64
xcrun notarytool submit dist/j-macos-x86_64.zip --wait
```

---

## 📝 Release Checklist

- [ ] Update version in all files
- [ ] Build all platform binaries
- [ ] Generate checksums
- [ ] Test installers on each platform
- [ ] Sign binaries (Windows/macOS)
- [ ] Create GitHub release
- [ ] Upload binaries and installers
- [ ] Update Homebrew formula
- [ ] Update package repositories
- [ ] Announce release

---

## 🤝 Contributing

To add support for a new platform:

1. Add target to `build-all-platforms.sh/ps1`
2. Create platform-specific installer script
3. Test on target platform
4. Update documentation
5. Submit pull request

---

## 📄 License

MIT License - See LICENSE file for details

---

## 🔗 Links

- **Website:** https://j-lang.org
- **GitHub:** https://github.com/j-lang/j
- **Documentation:** https://docs.j-lang.org
- **Discord:** https://discord.gg/j-lang

---

**Built with ❤️ by the J Language Team**
