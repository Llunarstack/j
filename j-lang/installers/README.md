# J Language - Installation Guide

Welcome to J! This guide will help you install the J programming language on your system.

## 🚀 Quick Install

### Windows (PowerShell)

Open PowerShell and run:

```powershell
cd path\to\j-lang\installers
.\install.ps1
```

### Linux/macOS (Bash)

Open terminal and run:

```bash
cd path/to/j-lang/installers
chmod +x install.sh
./install.sh
```

---

## 📦 Installation Methods

### Method 1: PowerShell Script (Windows) - RECOMMENDED

**Pros:**
- ✅ Simple one-command install
- ✅ No additional software needed
- ✅ Automatic PATH configuration
- ✅ File association for .j files
- ✅ Easy uninstall

**Steps:**

1. Open PowerShell
2. Navigate to installers directory:
   ```powershell
   cd j-lang\installers
   ```
3. Run installer:
   ```powershell
   .\install.ps1
   ```
4. Restart your terminal or refresh PATH:
   ```powershell
   $env:Path = [System.Environment]::GetEnvironmentVariable('Path','User')
   ```
5. Verify:
   ```powershell
   j --version
   ```

**Uninstall:**
```powershell
.\install.ps1 -Uninstall
```

---

### Method 2: Bash Script (Linux/macOS) - RECOMMENDED

**Pros:**
- ✅ Simple one-command install
- ✅ No additional software needed
- ✅ Automatic PATH configuration
- ✅ Works on all Unix-like systems

**Steps:**

1. Open terminal
2. Navigate to installers directory:
   ```bash
   cd j-lang/installers
   ```
3. Make executable:
   ```bash
   chmod +x install.sh
   ```
4. Run installer:
   ```bash
   ./install.sh
   ```
5. Restart your terminal or source config:
   ```bash
   source ~/.bashrc  # or ~/.zshrc
   ```
6. Verify:
   ```bash
   j --version
   ```

**Uninstall:**
```bash
./install.sh --uninstall
```

---

### Method 3: GUI Installer (Windows) - PROFESSIONAL

**Pros:**
- ✅ Professional Windows installer
- ✅ Graphical wizard interface
- ✅ Custom install location
- ✅ Optional desktop shortcut
- ✅ Appears in Add/Remove Programs

**Requirements:**
- Inno Setup compiler (to build the installer)
- Download from: https://jrsoftware.org/isdl.php

**To Build:**

1. Install Inno Setup
2. Open PowerShell:
   ```powershell
   cd j-lang\installers
   iscc j-lang-setup.iss
   ```
3. Installer will be created at:
   ```
   j-lang\dist\installers\j-lang-0.1.0-windows-setup.exe
   ```

**To Install:**

1. Double-click `j-lang-0.1.0-windows-setup.exe`
2. Follow the wizard
3. Choose options:
   - Install location
   - Add to PATH (recommended)
   - Create desktop icon
   - Associate .j files
4. Click Install

**Uninstall:**
- Use Windows "Add or Remove Programs"
- Or run the uninstaller from Start Menu

---

## 📍 Installation Locations

### Windows (PowerShell Script)
- **Binary**: `%LOCALAPPDATA%\J\bin\j.exe`
- **Examples**: `%LOCALAPPDATA%\J\examples\`
- **Icon**: `%LOCALAPPDATA%\J\J_lang_logo.ico`

### Windows (GUI Installer)
- **Default**: `C:\Program Files\J\`
- **User choice**: Custom location during install

### Linux/macOS
- **Binary**: `~/.j/bin/j`
- **Examples**: `~/.j/examples/`

---

## ✅ Verify Installation

After installation, verify J is working:

```bash
# Check version
j --version

# Start REPL
j repl

# Run example
j run examples/basic.j

# Check syntax
j check examples/basic.j
```

---

## 🔧 Manual Installation

If you prefer to install manually:

### Windows

1. Copy `j-windows-x86_64.exe` to a directory (e.g., `C:\J\`)
2. Rename to `j.exe`
3. Add directory to PATH:
   - Open System Properties → Environment Variables
   - Edit user PATH variable
   - Add `C:\J\`
4. Restart terminal

### Linux/macOS

1. Copy binary to `~/.local/bin/j` or `/usr/local/bin/j`
2. Make executable: `chmod +x ~/.local/bin/j`
3. Add to PATH in `~/.bashrc` or `~/.zshrc`:
   ```bash
   export PATH="$PATH:$HOME/.local/bin"
   ```
4. Restart terminal

---

## 🐛 Troubleshooting

### "j is not recognized" (Windows)

**Solution 1**: Refresh PATH in current terminal
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','User')
```

**Solution 2**: Restart terminal

**Solution 3**: Manually add to PATH
1. Open System Properties → Environment Variables
2. Edit user PATH
3. Add: `%LOCALAPPDATA%\J\bin`

### "command not found: j" (Linux/macOS)

**Solution 1**: Source shell config
```bash
source ~/.bashrc  # or ~/.zshrc
```

**Solution 2**: Restart terminal

**Solution 3**: Manually add to PATH
```bash
echo 'export PATH="$PATH:$HOME/.j/bin"' >> ~/.bashrc
source ~/.bashrc
```

### Binary not found during install

**Solution**: Build from source first
```bash
cd j-lang
cargo build --release
```

Then run installer again.

### Permission denied (Linux/macOS)

**Solution**: Make installer executable
```bash
chmod +x install.sh
```

---

## 🔄 Updating

To update J to a new version:

1. Build new version:
   ```bash
   cd j-lang
   cargo build --release
   ```

2. Run installer again:
   ```bash
   cd installers
   ./install.ps1  # Windows
   ./install.sh   # Linux/macOS
   ```

The installer will overwrite the old version.

---

## 🗑️ Uninstalling

### PowerShell Script (Windows)
```powershell
cd j-lang\installers
.\install.ps1 -Uninstall
```

### Bash Script (Linux/macOS)
```bash
cd j-lang/installers
./install.sh --uninstall
```

### GUI Installer (Windows)
- Windows Settings → Apps → J Programming Language → Uninstall
- Or Start Menu → J Programming Language → Uninstall

### Manual Uninstall

**Windows:**
1. Delete `%LOCALAPPDATA%\J`
2. Remove from PATH (Environment Variables)
3. Delete registry keys (optional):
   - `HKCU\Software\Classes\.j`
   - `HKCU\Software\Classes\JSourceFile`

**Linux/macOS:**
1. Delete `~/.j`
2. Remove from shell config (`~/.bashrc`, `~/.zshrc`)

---

## 🎯 Next Steps

After installation:

1. **Try the REPL:**
   ```bash
   j repl
   ```

2. **Run examples:**
   ```bash
   j run examples/basic.j
   j run examples/math_utils.j
   ```

3. **Create a project:**
   ```bash
   j jolt init my-project
   cd my-project
   j run main.j
   ```

4. **Install VS Code extension:**
   - Open VS Code
   - Go to Extensions
   - Search for "J Language"
   - Install

5. **Read documentation:**
   - See `docs/` folder
   - Visit https://docs.j-lang.org

---

## 📊 Platform Support

| Platform | Architecture | Status |
|----------|-------------|--------|
| Windows | x86_64 | ✅ Tested |
| Windows | i686 | ✅ Built |
| Windows | ARM64 | ⏳ Planned |
| Linux | x86_64 | ✅ Ready |
| Linux | i686 | ✅ Ready |
| Linux | ARM64 | ✅ Ready |
| Linux | ARMv7 | ✅ Ready |
| macOS | Intel | ✅ Ready |
| macOS | Apple Silicon | ✅ Ready |
| FreeBSD | x86_64 | ✅ Ready |

---

## 🤝 Support

Need help?

- **Documentation**: `docs/` folder
- **Examples**: `examples/` folder
- **Issues**: https://github.com/j-lang/j/issues
- **Discord**: https://discord.gg/j-lang

---

## 📄 License

MIT License - See LICENSE file for details

---

**Happy coding with J! 🚀**
