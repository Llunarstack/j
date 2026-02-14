# J Language - Installer Quick Start

Get J installed on your system in under 5 minutes!

---

## 🚀 Quick Install

### Windows

Open PowerShell and run:
```powershell
cd j-lang
.\install.ps1
```

That's it! J is now installed.

### Linux/macOS

Open Terminal and run:
```bash
cd j-lang
chmod +x install.sh
./install.sh
```

Done! J is ready to use.

---

## ✅ Verify Installation

```bash
# Check version
j --version

# Start REPL
j repl

# Run example
j run examples/basic.j
```

---

## 🛠️ For Developers: Build Everything

### 1. Build All Binaries

**Windows:**
```powershell
.\build-all-platforms.ps1
```

**Linux/macOS:**
```bash
chmod +x build-all-platforms.sh
./build-all-platforms.sh
```

This creates binaries in `dist/` for:
- Windows (x86, x64, ARM64)
- Linux (x86, x64, ARM, ARM64, ARMv7)
- macOS (Intel, Apple Silicon)
- FreeBSD (x64)

### 2. Build Installers (Optional)

```bash
chmod +x build-installers.sh

# Build all
./build-installers.sh --all

# Or build specific ones
./build-installers.sh --deb    # Debian package
./build-installers.sh --rpm    # RPM package
./build-installers.sh --macos  # macOS package (on macOS only)
```

### 3. Build Windows GUI Installer (Optional)

Requires [Inno Setup](https://jrsoftware.org/isinfo.php):
```powershell
iscc installer-windows.iss
```

---

## 📦 What Gets Installed

### Windows
- **Binary:** `%LOCALAPPDATA%\J\bin\j.exe`
- **Examples:** `%LOCALAPPDATA%\J\examples\`
- **Added to PATH:** Yes
- **File association:** .j files open with J
- **Desktop shortcut:** J REPL

### Linux/macOS
- **Binary:** `~/.j/bin/j`
- **Examples:** `~/.j/examples/`
- **Added to PATH:** Yes (in ~/.bashrc, ~/.zshrc, etc.)
- **Shell integration:** bash, zsh, fish

---

## 🗑️ Uninstall

### Windows
```powershell
.\install.ps1 -Uninstall
```

### Linux/macOS
```bash
./install.sh --uninstall
```

---

## 🎯 Installation Methods

| Method | Command | Best For |
|--------|---------|----------|
| PowerShell Script | `.\install.ps1` | Windows quick install |
| Bash Script | `./install.sh` | Linux/macOS quick install |
| GUI Installer | Double-click .exe | Windows users who prefer GUI |
| Debian Package | `sudo dpkg -i *.deb` | Ubuntu/Debian systems |
| RPM Package | `sudo rpm -i *.rpm` | Fedora/RHEL systems |
| macOS Package | Double-click .pkg | macOS users who prefer GUI |
| Homebrew | `brew install j-lang` | macOS/Linux developers |

---

## 🔧 Troubleshooting

### "Command not found" after install

**Solution:** Restart your terminal or run:

**Windows:**
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','User')
```

**Linux/macOS:**
```bash
source ~/.bashrc  # or ~/.zshrc
```

### Permission denied

**Linux/macOS:**
```bash
chmod +x install.sh
```

### Build fails

Make sure you have Rust installed:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

---

## 📚 More Information

- **Full Documentation:** `INSTALLER_README.md`
- **Project README:** `README.md`
- **Examples:** `examples/` directory
- **GitHub:** https://github.com/j-lang/j

---

## 🎉 You're Ready!

J is now installed. Try these commands:

```bash
# Interactive REPL
j repl

# Run a file
j run examples/basic.j

# Create new project
j jolt init my-project

# Get help
j --help
```

Happy coding with J! 🚀
