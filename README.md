    # J Programming Language

<div align="center">

![J Language Logo](j-lang/J_lang_logo.ico)

**A modern, safe, fast, and productive programming language**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()
[![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)]()

[Quick Start](#-quick-start) • [Features](#-features) • [Installation](#-installation) • [Documentation](#-documentation) • [Examples](#-examples)

</div>

---

## 🚀 Quick Start

### Install J (Windows)

```powershell
cd j-lang\installers
.\install.bat
```

### Your First J Program

```j
# hello.j
str | greeting -> "Hello, World!"
out(greeting)

int | x -> 42
int | y -> 10
out("The answer is: " + str(x + y))
```

Run it:
```bash
j run hello.j
```

### Try the REPL

```bash
j repl
```

```j
> int | x -> 42
> out(x)
42
> str | name -> "J Language"
> out("Welcome to " + name)
Welcome to J Language
```

---

## ✨ Features

### 🎯 Modern Syntax
- **Type inference** with explicit type annotations
- **Pattern matching** for elegant control flow
- **Traits and generics** for code reuse
- **Async/await** for concurrent programming

### ⚡ Performance
- **JIT compilation** for fast execution
- **AOT compilation** for native binaries
- **Zero-cost abstractions**
- **Memory safety** without garbage collection

### 🛠️ Developer Experience
- **Interactive REPL** for rapid prototyping
- **Rich error messages** with helpful suggestions
- **VS Code extension** with syntax highlighting and IntelliSense
- **Package manager (Jolt)** for dependency management

### 🌍 Cross-Platform
- Windows (x64, x86, ARM64)
- Linux (x64, x86, ARM64, ARMv7)
- macOS (Intel, Apple Silicon)

---

## 📦 Installation

### Windows

**Option 1: Quick Install (Recommended)**
```powershell
cd j-lang\installers
.\install.bat
```

**Option 2: Compile Native Installer**
```powershell
cd j-lang\installers
.\build-installer-auto.bat
# Creates j-installer.exe
```

### Linux/macOS

```bash
cd j-lang/installers
chmod +x install.sh
./install.sh
```

### Verify Installation

```bash
j --version
# Output: j 0.1.0
```

**See [Installation Guide](HOW_TO_INSTALL.md) for more options**

---

## 🎓 Language Features

### Variables and Types

```j
# Basic types
int | x -> 42
float | pi -> 3.14159
str | name -> "Alice"
bool | flag -> true

# Collections
list<int> | numbers -> [1, 2, 3, 4, 5]
map<str, int> | ages -> {"Alice": 30, "Bob": 25}

# Type inference
auto | value -> 42  # Inferred as int
```

### Functions

```j
# Function definition
fn add(int | a, int | b) -> int {
    return a + b
}

# Lambda functions
auto | multiply -> fn(int | a, int | b) -> a * b

# Higher-order functions
list<int> | doubled -> numbers.map(fn(x) -> x * 2)
```

### Control Flow

```j
# If expressions
if x > 10 {
    out("Large")
} else if x > 5 {
    out("Medium")
} else {
    out("Small")
}

# Pattern matching
match value {
    0 -> out("Zero")
    1..10 -> out("Small")
    _ -> out("Large")
}

# Loops
for i in range(0, 10) {
    out(i)
}

while x < 100 {
    x = x * 2
}
```

### Advanced Features

```j
# Traits
trait Printable {
    fn print(self)
}

# Generics
fn max<T>(T | a, T | b) -> T where T: Comparable {
    return if a > b { a } else { b }
}

# Async/await
async fn fetch_data(str | url) -> Result<str> {
    auto | response -> await http.get(url)
    return response.text()
}

# Error handling
fn divide(int | a, int | b) -> Result<int> {
    if b == 0 {
        return Err("Division by zero")
    }
    return Ok(a / b)
}
```

---

## 📚 Documentation

- **[Getting Started](GET_STARTED.md)** - Complete tutorial for beginners
- **[Installation Guide](HOW_TO_INSTALL.md)** - All installation methods
- **[Language Reference](docs/NEW_FEATURES_ADDED.md)** - Complete language features
- **[Module System](docs/MODULE_SYSTEM_COMPLETE.md)** - Code organization
- **[VS Code Extension](docs/VSCODE_EXTENSION_COMPLETE.md)** - Editor setup
- **[Build Instructions](docs/BUILD_INSTRUCTIONS.md)** - Build from source

---

## 💻 Examples

### Hello World

```j
str | message -> "Hello, World!"
out(message)
```

### Fibonacci Sequence

```j
fn fibonacci(int | n) -> int {
    if n <= 1 {
        return n
    }
    return fibonacci(n - 1) + fibonacci(n - 2)
}

for i in range(0, 10) {
    out(fibonacci(i))
}
```

### Web Server (Coming Soon)

```j
import http

async fn main() {
    auto | server -> http.Server.new("127.0.0.1:8080")
    
    server.get("/", fn(req) -> {
        return http.Response.ok("Hello from J!")
    })
    
    await server.start()
}
```

**More examples in [`j-lang/examples/`](j-lang/examples/)**

---

## 🎮 Commands

```bash
j repl              # Start interactive REPL
j run <file>        # Run a J program
j build <file>      # Compile to native binary
j check <file>      # Check syntax without running
j fmt <file>        # Format code
j test              # Run tests
j jolt init <name>  # Create new project
j jolt add <pkg>    # Add dependency
j jolt build        # Build project
j --version         # Show version
j --help            # Show help
```

---

## 🔧 Development

### Build from Source

```bash
# Clone repository
git clone https://github.com/yourusername/j.git
cd j/j-lang

# Build
cargo build --release

# Run tests
cargo test

# Install
cd installers
./install.sh  # Linux/macOS
.\install.ps1 # Windows
```

### Project Structure

```
j/
├── j-lang/                 # Main language implementation
│   ├── src/               # Rust source code
│   │   ├── lexer.rs      # Lexical analysis
│   │   ├── parser.rs     # Syntax analysis
│   │   ├── interpreter.rs # Execution engine
│   │   ├── compiler.rs   # AOT compiler
│   │   └── jit.rs        # JIT compiler
│   ├── examples/          # Example programs
│   ├── installers/        # Installation scripts
│   ├── vscode-extension/  # VS Code extension
│   └── dist/              # Built executables
├── docs/                  # Documentation
└── README.md              # This file
```

---

## 🎨 VS Code Extension

Install the J Language extension for the best development experience:

**Features:**
- Syntax highlighting
- 40+ code snippets
- IntelliSense
- Run & debug
- REPL integration
- Error highlighting

**Install:**
1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Search for "J Language"
4. Click Install

Or install from source:
```bash
cd j-lang/vscode-extension
npm install
npm run compile
code --install-extension .
```

---

## 📦 Package Manager (Jolt)

J comes with Jolt, a built-in package manager:

```bash
# Create new project
j jolt init my-project
cd my-project

# Add dependencies
j jolt add http
j jolt add json

# Build project
j jolt build

# Run project
j run main.j
```

**Project structure:**
```
my-project/
├── jolt.toml          # Project configuration
├── main.j             # Entry point
└── src/               # Source files
```

---

## 🌟 Roadmap

- [x] Core language features
- [x] REPL
- [x] Module system
- [x] Package manager (Jolt)
- [x] VS Code extension
- [x] Multi-platform installers
- [ ] Standard library expansion
- [ ] Web framework
- [ ] Database drivers
- [ ] Async runtime
- [ ] Language server protocol (LSP)
- [ ] Debugger
- [ ] Package registry

---

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) first.

### Ways to Contribute

- 🐛 Report bugs
- 💡 Suggest features
- 📝 Improve documentation
- 🔧 Submit pull requests
- ⭐ Star the repository

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🔗 Links

- **Website**: https://j-lang.org (coming soon)
- **GitHub**: https://github.com/yourusername/j
- **Documentation**: https://docs.j-lang.org (coming soon)
- **Discord**: https://discord.gg/j-lang (coming soon)
- **Twitter**: @jlanguage (coming soon)

---

## 🙏 Acknowledgments

Built with ❤️ using:
- [Rust](https://www.rust-lang.org/) - Systems programming language
- [LLVM](https://llvm.org/) - Compiler infrastructure
- [Cranelift](https://cranelift.dev/) - JIT compiler

---

## 📊 Stats

- **Lines of Code**: ~15,000
- **Supported Platforms**: 9
- **Built-in Functions**: 50+
- **Example Programs**: 20+
- **VS Code Snippets**: 40+

---

<div align="center">

**[⬆ Back to Top](#j-programming-language)**

Made with ❤️ by the J Language Team

**Star ⭐ this repository if you find it useful!**

</div>
