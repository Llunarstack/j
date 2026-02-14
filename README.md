<div align="center">

# J Programming Language

**A modern, expressive, and powerful programming language designed for productivity**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()
[![Version](https://img.shields.io/badge/version-0.1.0-orange.svg)](CHANGELOG.md)

[Getting Started](#installation) •
[Documentation](#documentation) •
[Examples](j-lang/examples/) •
[Contributing](CONTRIBUTING.md)

</div>

---

## About

J is a modern programming language that combines the expressiveness of dynamic languages with the safety and performance of statically typed systems. Built with Rust, J offers a unique syntax designed for clarity and rapid development.

## Why J?

- **Expressive Syntax** - Clear, readable code with minimal boilerplate
- **Type Safety** - Strong typing with intelligent type inference
- **Modern Features** - Async/await, traits, pattern matching, and more
- **Fast Execution** - JIT compilation and optimization support
- **Rich Standard Library** - Comprehensive collection of built-in utilities
- **Developer Friendly** - Excellent error messages and tooling support

## Key Features

### Type System
Strong static typing with inference, supporting integers, floats, strings, collections, and custom types.

### Concurrency
Built-in async/await syntax for writing concurrent code without complexity.

### Module System
Organize and share code with a straightforward import/export mechanism.

### Traits
Define shared behavior across types with trait-based polymorphism.

### Advanced Collections
Native support for vectors, matrices, grids, graphs, trees, and specialized data structures.

### Pattern Matching
Powerful pattern matching for control flow and data destructuring.

### JIT Compilation
Optional just-in-time compilation for performance-critical applications.

## Installation

### Quick Install

**From Source:**
```bash
git clone https://github.com/Llunarstack/j.git
cd j/j-lang
cargo build --release
```

**Using Cargo:**
```bash
cargo install --path j-lang
```

### Platform-Specific Installers

Pre-built installers are available for multiple platforms:

- **Windows**: MSI and EXE installers
- **macOS**: PKG installer
- **Linux**: DEB and RPM packages

See [installers/](j-lang/installers/) for detailed installation instructions.

## Getting Started

### Run the REPL
```bash
j repl
```

### Execute a Program
```bash
j run your_program.j
```

### Compile to Binary
```bash
j compile your_program.j -o output
```

## Documentation

- **[Language Guide](j-lang/README.md)** - Complete language reference
- **[Standard Library](j-lang/lib/)** - Built-in modules and functions
- **[Examples](j-lang/examples/)** - Sample programs and tutorials
- **[Contributing Guide](CONTRIBUTING.md)** - How to contribute
- **[Changelog](CHANGELOG.md)** - Version history and updates

## Development

### Building from Source

**Prerequisites:**
- Rust 1.70 or higher
- Cargo

**Build:**
```bash
cd j-lang
cargo build --release
```

**Run Tests:**
```bash
cargo test
cargo test --all-features
```

**Format and Lint:**
```bash
cargo fmt
cargo clippy
```

## Editor Support

### VS Code Extension
A full-featured VS Code extension is available in [vscode-extension/](j-lang/vscode-extension/) with:
- Syntax highlighting
- Code snippets
- Language configuration
- Custom themes

## Project Structure

```
j/
├── j-lang/              # Core language implementation
│   ├── src/             # Rust source code
│   ├── lib/             # Standard library
│   ├── tests/           # Test suite
│   ├── examples/        # Example programs
│   └── installers/      # Platform installers
├── LICENSE              # MIT License
├── README.md            # This file
├── CONTRIBUTING.md      # Contribution guidelines
├── CODE_OF_CONDUCT.md   # Community guidelines
└── CHANGELOG.md         # Version history
```

## Community

### Contributing

We welcome contributions! Please read our [Contributing Guide](CONTRIBUTING.md) to get started.

### Code of Conduct

This project adheres to a [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

### Getting Help

- **Issues**: [GitHub Issues](https://github.com/Llunarstack/j/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Llunarstack/j/discussions)

## Roadmap

- [ ] Package manager and registry
- [ ] Language server protocol (LSP) support
- [ ] Debugger integration
- [ ] WebAssembly compilation target
- [ ] Comprehensive standard library expansion
- [ ] Performance optimizations and benchmarks

## License

J is distributed under the [MIT License](LICENSE). See LICENSE for more information.

## Acknowledgments

Built with Rust and inspired by modern language design principles.

---

<div align="center">

**[Website](#) • [Documentation](#documentation) • [Community](#community)**

Made with ❤️ by the J Language Team

</div>
