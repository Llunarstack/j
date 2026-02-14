# The J Programming Language

This is the main source code repository for J. It contains the compiler, standard library, and documentation.

## Why J?

**Performance:** Fast execution with JIT compilation support, suitable for performance-critical applications and easily integrated with other languages.

**Reliability:** Rich type system with strong typing and type inference ensure type safety, reducing bugs at compile-time.

**Productivity:** Expressive syntax, comprehensive standard library, excellent error diagnostics, and integrated tooling including package management, REPL, and editor support.

## Quick Start

Read the [Language Guide](j-lang/README.md) to learn J.

## Installing from Source

**Note:** If you wish to contribute or modify J, building from source is recommended.

### Prerequisites
- Rust 1.70 or higher
- Cargo

### Build and Install
```bash
git clone https://github.com/Llunarstack/j.git
cd j/j-lang
cargo build --release
cargo install --path .
```

### Platform-Specific Installers
Pre-built installers are available in [j-lang/installers/](j-lang/installers/) for Windows, macOS, and Linux.

## Getting Help

See the [examples directory](j-lang/examples/) for sample programs and tutorials.

For questions and discussions, open an issue on [GitHub Issues](https://github.com/Llunarstack/j/issues).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## License

J is distributed under the terms of the MIT license.

See [LICENSE](LICENSE) for details.

## Trademark

The J language name and logo are trademarks. If you want to use these names or brands, please open an issue to discuss.
