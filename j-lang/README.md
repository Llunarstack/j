# J Language - Core Implementation

This directory contains the core implementation of the J Programming Language.

## 📁 Directory Structure

```
j-lang/
├── src/                    # Rust source code
│   ├── main.rs            # Entry point
│   ├── lexer.rs           # Lexical analyzer
│   ├── parser.rs          # Parser
│   ├── interpreter.rs     # Interpreter
│   ├── compiler.rs        # AOT compiler
│   ├── jit.rs             # JIT compiler
│   ├── runtime.rs         # Runtime system
│   ├── jolt.rs            # Package manager
│   ├── repl.rs            # REPL
│   └── error.rs           # Error handling
├── examples/              # Example J programs
├── installers/            # Installation scripts
├── scripts/               # Build/setup scripts
├── vscode-extension/      # VS Code extension
├── dist/                  # Built executables
├── target/                # Cargo build output
├── Cargo.toml             # Rust project config
└── README.md              # This file
```

## 🔨 Building

### Debug Build
```bash
cargo build
```

### Release Build
```bash
cargo build --release
```

### Build for All Platforms
```bash
cd installers
./build-all-platforms.sh  # Linux/macOS
.\build-all-platforms.ps1  # Windows
```

## 🧪 Testing

### Run Tests
```bash
cargo test
```

### Run Example
```bash
cargo run --release -- run examples/basic.j
```

### Start REPL
```bash
cargo run --release -- repl
```

## 📦 Installation

### Quick Install
```bash
cd installers
./install.sh  # Linux/macOS
.\install.ps1  # Windows
```

### Build Packages
```bash
cd installers
./build-deb.sh      # Debian package
./build-rpm.sh      # RPM package
./build-macos-pkg.sh # macOS package
```

## 🎨 VS Code Extension

### Development
```bash
cd vscode-extension
npm install
npm run compile
# Press F5 in VS Code to test
```

### Package
```bash
cd vscode-extension
npm run package
# Creates j-lang-0.1.0.vsix
```

## 📊 Features

- **200+ language features**
- **Module system**
- **Package manager (Jolt)**
- **REPL**
- **JIT compilation**
- **AOT compilation**
- **Async/await**
- **Pattern matching**
- **Traits**
- **Decorators**

## 🚀 Performance

- **Compile time**: Fast incremental compilation
- **Runtime**: JIT-optimized execution
- **Binary size**: ~1.5 MB (release build)
- **Memory**: Efficient memory management

## 📝 Documentation

See the main [README](../README.md) and [docs](../docs/) directory.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests: `cargo test`
5. Submit a pull request

## 📄 License

MIT License - See LICENSE file for details
