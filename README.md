<p align="center">
  <strong>J</strong> — expressive language for data & algorithms
</p>

<p align="center">
  <img src="J_lang_logo.ico" width="64" height="64" alt="J logo" />
</p>

# J Programming Language

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Rust](https://img.shields.io/badge/rust-1.70%2B-orange.svg)](https://www.rust-lang.org/)
[![CI](https://github.com/Llunarstack/j/actions/workflows/ci.yml/badge.svg)](https://github.com/Llunarstack/j/actions/workflows/ci.yml)

**J** is an expressive programming language and toolchain for data-heavy and algorithmic code. This repository contains the interpreter, standard library, examples, and editor support.

---

## Features

| Area | Highlights |
|------|------------|
| **Language** | Typed variables, pattern matching, `cond`, lambdas, pipelines (`\|>`), classes |
| **Data structures** | Lists, dicts, sets, graphs, deques, priority queues, matrices |
| **Algorithms** | Built-in: `two_sum`, `prefix_sum`, `bfs`/`dfs`, `count_if`, sliding window, LIS, and more |
| **Loops** | `for`, `sweep`, `meet`, `binary`, `while_nonzero`, `while_change` |
| **Tooling** | CLI, REPL, module system, VS Code extension, multi-platform installers |

## Quick start

```bash
git clone https://github.com/Llunarstack/j.git
cd j/j-lang
cargo build --release
cargo run -- run examples/analytics_pipeline/main.j
```

**REPL**

```bash
cargo run -- repl
```

**Install globally**

```bash
cargo install --path j-lang
j run path/to/file.j
```

## Project layout

```
j/
├── j-lang/              # Main crate (interpreter + CLI)
│   ├── src/             # Lexer, parser, interpreter, REPL, crypto
│   ├── stdlib/          # Standard library (.j modules)
│   ├── doc/             # Design docs and specs
│   ├── examples/        # Example programs (FizzBuzz, Stellar Dungeon, Analytics Pipeline)
│   ├── tests/           # Integration tests and fixtures
│   ├── vscode-extension/
│   └── installers/      # Pre-built installers
├── CONTRIBUTING.md
├── CHANGELOG.md
├── PROJECT_STRUCTURE.md
└── LICENSE (MIT)
```

See [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for a detailed map of the codebase.

## Documentation

- **Build & usage:** [j-lang/README.md](j-lang/README.md)
- **Doc index:** [j-lang/doc/README.md](j-lang/doc/README.md)
- **Advanced features:** [j-lang/doc/ADVANCED_LOOPS.md](j-lang/doc/ADVANCED_LOOPS.md), [j-lang/doc/BUILTIN_ALGORITHMS.md](j-lang/doc/BUILTIN_ALGORITHMS.md), [j-lang/doc/ADVANCED_CLASS_TYPES.md](j-lang/doc/ADVANCED_CLASS_TYPES.md)

## Status

**Version:** 0.1.0 (experimental). APIs and language details may change. See [CHANGELOG.md](CHANGELOG.md).

## Contributing

We welcome contributions. Please read [CONTRIBUTING.md](CONTRIBUTING.md) and the [Code of Conduct](CODE_OF_CONDUCT.md). Use [GitHub Issues](https://github.com/Llunarstack/j/issues) for bugs and feature requests.

## License

MIT. See [LICENSE](LICENSE).

## Trademark

The name **J** and the J logo are used for this project. If you want to use these for another project, please open an issue to discuss.
