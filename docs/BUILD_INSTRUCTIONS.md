# J Language - Build Instructions

Complete guide for building J Language executables for all platforms.

---

## 🚀 Quick Build (Current Platform)

### Windows
```powershell
cd j-lang
cargo build --release
```

### Linux/macOS
```bash
cd j-lang
cargo build --release
```

The executable will be in `target/release/j` (or `j.exe` on Windows).

---

## 🌍 Cross-Platform Builds

### Option 1: GitHub Actions (Recommended)

The repository includes a GitHub Actions workflow that automatically builds for all platforms.

**Trigger a build:**
1. Push a tag: `git tag v0.1.0 && git push origin v0.1.0`
2. Or manually trigger from GitHub Actions tab

**Platforms built:**
- Windows (x64, i686)
- Linux (x64, ARM64)
- macOS (Intel, Apple Silicon)

### Option 2: Native Builds

Build on each platform natively for best results.

**Windows:**
```powershell
cd j-lang
cargo build --release --target x86_64-pc-windows-msvc
cargo build --release --target i686-pc-windows-msvc
```

**Linux:**
```bash
cd j-lang
cargo build --release --target x86_64-unknown-linux-gnu
cargo build --release --target aarch64-unknown-linux-gnu
```

**macOS:**
```bash
cd j-lang
cargo build --release --target x86_64-apple-darwin
cargo build --release --target aarch64-apple-darwin
```

### Option 3: Docker Cross-Compilation

Use Docker for cross-platform builds:

```bash
# Linux from Windows/macOS
docker run --rm -v ${PWD}:/app -w /app/j-lang rust:latest cargo build --release

# With cross tool
cargo install cross
cross build --release --target x86_64-unknown-linux-gnu
```

---

## 📦 Using Build Scripts

### Build All Platforms (Automated)

**Windows:**
```powershell
cd j-lang/installers
.\build-all-platforms.ps1
```

**Linux/macOS:**
```bash
cd j-lang/installers
chmod +x build-all-platforms.sh
./build-all-platforms.sh
```

This script:
- Detects available targets
- Builds for all supported platforms
- Creates executables in `dist/`
- Generates checksums

---

## 🎯 Platform-Specific Notes

### Windows

**Requirements:**
- Visual Studio Build Tools or Visual Studio
- Rust (via rustup)

**Targets:**
- `x86_64-pc-windows-msvc` - 64-bit (recommended)
- `i686-pc-windows-msvc` - 32-bit
- `aarch64-pc-windows-msvc` - ARM64

**Build:**
```powershell
rustup target add x86_64-pc-windows-msvc
cargo build --release --target x86_64-pc-windows-msvc
```

### Linux

**Requirements:**
- GCC or Clang
- Rust (via rustup)

**Targets:**
- `x86_64-unknown-linux-gnu` - 64-bit Intel/AMD
- `i686-unknown-linux-gnu` - 32-bit Intel/AMD
- `aarch64-unknown-linux-gnu` - ARM64
- `armv7-unknown-linux-gnueabihf` - ARMv7

**Build:**
```bash
rustup target add x86_64-unknown-linux-gnu
cargo build --release --target x86_64-unknown-linux-gnu
```

**Cross-compilation for ARM:**
```bash
sudo apt-get install gcc-aarch64-linux-gnu
rustup target add aarch64-unknown-linux-gnu
cargo build --release --target aarch64-unknown-linux-gnu
```

### macOS

**Requirements:**
- Xcode Command Line Tools
- Rust (via rustup)

**Targets:**
- `x86_64-apple-darwin` - Intel Macs
- `aarch64-apple-darwin` - Apple Silicon (M1/M2)

**Build:**
```bash
rustup target add x86_64-apple-darwin
cargo build --release --target x86_64-apple-darwin
```

**Universal Binary:**
```bash
# Build both architectures
cargo build --release --target x86_64-apple-darwin
cargo build --release --target aarch64-apple-darwin

# Combine into universal binary
lipo -create \
  target/x86_64-apple-darwin/release/j \
  target/aarch64-apple-darwin/release/j \
  -output j-universal
```

---

## 🔧 Build Optimization

### Release Build (Optimized)
```bash
cargo build --release
```

### Debug Build (Fast compilation)
```bash
cargo build
```

### Custom Optimization
Edit `Cargo.toml`:
```toml
[profile.release]
opt-level = 3        # Maximum optimization
lto = true          # Link-time optimization
codegen-units = 1   # Better optimization
strip = true        # Strip symbols (smaller binary)
```

---

## 📊 Build Sizes

Typical release build sizes:

| Platform | Size | Stripped |
|----------|------|----------|
| Windows x64 | ~1.5 MB | ~1.2 MB |
| Linux x64 | ~1.8 MB | ~1.3 MB |
| macOS x64 | ~1.6 MB | ~1.4 MB |

---

## 🧪 Testing Builds

### Test Executable
```bash
# Check version
./j --version

# Run REPL
./j repl

# Run example
./j run examples/basic.j

# Check syntax
./j check examples/basic.j
```

### Run Test Suite
```bash
cd j-lang
cargo test
```

---

## 📦 Creating Installers

After building executables, create installers:

### Windows Installer
```powershell
cd j-lang/installers
# Requires Inno Setup installed
iscc installer-windows.iss
```

### Linux Packages
```bash
cd j-lang/installers
./build-deb.sh  # Debian/Ubuntu
./build-rpm.sh  # Fedora/RHEL
```

### macOS Package
```bash
cd j-lang/installers
./build-macos-pkg.sh
```

---

## 🐛 Troubleshooting

### "linker not found"
**Solution:** Install build tools
- Windows: Visual Studio Build Tools
- Linux: `sudo apt-get install build-essential`
- macOS: `xcode-select --install`

### "target not found"
**Solution:** Add target
```bash
rustup target add <target-name>
```

### Cross-compilation fails
**Solution:** Use native builds or Docker

### Out of memory
**Solution:** Reduce parallel jobs
```bash
cargo build --release -j 2
```

---

## 📝 CI/CD Integration

### GitHub Actions
See `.github/workflows/build-release.yml`

### GitLab CI
```yaml
build:
  image: rust:latest
  script:
    - cd j-lang
    - cargo build --release
  artifacts:
    paths:
      - j-lang/target/release/j
```

### Jenkins
```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'cd j-lang && cargo build --release'
            }
        }
    }
}
```

---

## 🔐 Code Signing

### Windows
```powershell
signtool sign /f certificate.pfx /p password /t http://timestamp.digicert.com j.exe
```

### macOS
```bash
codesign --sign "Developer ID Application" j
xcrun notarytool submit j.zip --wait
```

---

## 📄 License

MIT License - See LICENSE file for details

---

**Last Updated**: February 13, 2026  
**Version**: 0.1.0
