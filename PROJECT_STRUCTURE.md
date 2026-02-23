# J — Project structure

Layout inspired by [Rust](https://github.com/rust-lang/rust) and [CPython](https://github.com/python/cpython): single root, clear separation of source, docs, tests, and standard library.

## Repository layout

```
j/
├── README.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── LICENSE
├── PROJECT_STRUCTURE.md   (this file)
├── .editorconfig
├── .gitignore
│
└── j-lang/                      # Main crate (compiler + interpreter)
    ├── Cargo.toml
    ├── rustfmt.toml
    ├── README.md
    │
    ├── src/                     # Rust source
    │   ├── main.rs              # CLI entry
    │   ├── lib.rs               # Library root
    │   ├── lexer.rs
    │   ├── parser.rs
    │   ├── interpreter/         # Interpreter (split into modules)
    │   │   ├── mod.rs
    │   │   ├── value.rs         # Value enum, Display
    │   │   ├── eval.rs          # AST evaluation (eval_node)
    │   │   └── call.rs          # Call dispatch, builtins, scope/module helpers
    │   ├── compiler.rs
    │   ├── error.rs
    │   ├── repl.rs
    │   ├── runtime.rs
    │   ├── jit.rs
    │   ├── jolt.rs
    │   └── crypto.rs
    │
    ├── doc/                     # Design docs, specs, status (Rust: doc; Python: Doc)
    │   └── README.md            # Index of documents
    │
    ├── stdlib/                  # Standard library (.j modules) (Python: Lib)
    │   ├── std/
    │   ├── math/
    │   ├── collections/
    │   └── io/
    │
    ├── tests/                   # Integration tests
    │   ├── integration/
    │   └── fixtures/            # .j test files
    │       ├── basic_types.j
    │       ├── strings.j
    │       └── root/            # Additional fixtures
    │
    ├── examples/                # Example programs
    ├── benches/                 # Benchmarks (optional)
    ├── scripts/                 # Build / install scripts
    ├── test-project/            # Sample Jolt project
    ├── vscode-extension/
    └── installers/
```

## Where things live

| Purpose           | Path                |
|-------------------|---------------------|
| **Source**        | `j-lang/src/`       |
| **Documentation** | `j-lang/doc/`       |
| **Standard lib**  | `j-lang/stdlib/`    |
| **Tests**        | `j-lang/tests/`     |
| **Examples**      | `j-lang/examples/`  |

Build and run from the crate root:

```bash
cd j-lang
cargo build
cargo run -- repl
cargo test
```

## Interpreter layout

The interpreter is split into four modules:

- **`interpreter/value.rs`** — `Value` enum, `ControlFlow`, `FutureState`, `TraitMethod`, `Display`.
- **`interpreter/eval.rs`** — `eval_node` (single match over all AST nodes).
- **`interpreter/mod.rs`** — `Interpreter` struct, `new`, `run`, `evaluate`, decorators, `call_function_internal`.
- **`interpreter/call.rs`** — `call_function`, builtins, `call_value`, `get_variable`, `set_variable`, `eval_binary_op`, `eval_unary_op`, `get_property`, scope/module helpers (`push_scope`, `pop_scope`, `load_module`, `execute_file`), and other helpers.
