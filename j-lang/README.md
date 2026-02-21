# J Programming Language

J is an experimental programming language and toolchain focused on expressive syntax and practical tooling. This repository contains the compiler/interpreter, standard library, examples, and editor support.

## Status

Version: 0.1.0 (experimental). APIs and language details may change between releases.

## Features (Implemented or In Progress)

- Interpreter with a CLI entry point
- Module system and standard library
- Pattern matching and structured control flow
- Async/await support (feature-gated in Rust build)
- VS Code extension for syntax highlighting

## Quick Start

### Build From Source

```bash
# From repo root
cd j-lang
cargo build --release
```

### Run an Example

```bash
# Using the local build
cargo run -- run examples/basic/hello.j
```

### Install Locally

```bash
cargo install --path .
```

### REPL

```bash
cargo run -- repl
```

## Project Structure

```
j-lang/
├── src/               # Core implementation
├── lib/               # Standard library
├── examples/          # Example programs
├── tests/             # Test suite
├── docs/              # Documentation
├── vscode-extension/  # VS Code support
└── installers/        # Platform installers
```

## Documentation

- `docs/FEATURES.md`
- `docs/ERROR_HANDLING.md`
- `docs/ADVANCED_LOOPS.md`
- `docs/BUILTIN_ALGORITHMS.md`
- `docs/CRYPTO_FEATURES.md`
- `docs/MATRIX_FEATURES.md`

## Development

### Prerequisites

- Rust 1.70+
- Cargo

### Code Quality

```bash
cargo fmt
cargo clippy
cargo test
```

## Contributing

See `../CONTRIBUTING.md` for contribution guidelines.

## License

MIT. See `../LICENSE`.
