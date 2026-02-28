<p align="center">
  <img src="assets/jade.png" width="120" alt="Jade logo">
</p>

<h1 align="center">Jade</h1>

<p align="center">
  <strong>An expressive language for data and algorithms.</strong>
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
  <a href="https://github.com/Llunarstack/j/actions/workflows/release.yml"><img src="https://github.com/Llunarstack/j/actions/workflows/release.yml/badge.svg" alt="CI"></a>
  <a href="https://www.rust-lang.org/"><img src="https://img.shields.io/badge/rust-1.70%2B-orange.svg" alt="Rust 1.70+"></a>
  <a href="CHANGELOG.md"><img src="https://img.shields.io/badge/version-1.0.0-green.svg" alt="Version 1.0.0"></a>
</p>

---

## What is Jade?

Jade is a **memory-safe**, **readable** language built for data and algorithms. Values flow through **pipelines** (`x |> f`); **cond** and **when** route a value into the first matching branch; **either** is a pipeline-style ternary. You get **pattern matching** with guards, **broadcast calls** (`fn.(list, scalar)`), and **borrow_split(list, i) |> left, right { ... }** to split a list and use both halves in one scope. A **converge** loop runs until the body’s result stops changing (fixed-point). Loops go beyond plain `for`: **indexed**, **reverse**, **step**, **zip**, **parallel**, **chunked**. First-class **graphs** (bfs, dfs, dijkstra, topological sort), **deques**, **priority queues**, **union-find**, **tries**, **ring buffers**, **sorted lists**, **sliding windows**. Declare variables with **enc** or **secret** for encryption and redaction. **memo(f)** in the stdlib; algo helpers like **lower_bound**, **upper_bound**, **prefix_sum**, **kadane**, **merge_sorted**, **sliding_window**, **two_pointers_sum**, **flood_fill**. One binary: interpreter, REPL, Jolt.

```jdl
fn | greet ( str | name ) > {
  out("Hello, " + name)
}

greet("Jade")
int: total = 0
for x in [1, 2, 3] { total = total + x }
out("Sum: " + total)
```

---

## Features

| | |
|---|---|
| **Pipelines & routing** | `x \|> f` passes `x` as `_` into `f`; chain as long as you like. **cond** / **when** push a value through `condition \|> body` branches; **either** expr `\|>` true_body `\|>` false_body. **Match** with guards. **borrow_split(list, i) \|> left, right { body }** splits and binds both sides. |
| **Loops that match algorithms** | **converge { body }** runs until the body returns the same value twice (fixed-point). **for** comes as indexed, reverse, step, zip, parallel, chunked. **Broadcast** calls: `fn.(list, scalar)` applies element-wise. |
| **Data structures in the language** | **Graph** (bfs, dfs, dijkstra, topological_sort), **deque**, **priority queue**, **union-find** (uf_new, uf_find, uf_union, uf_connected), **trie** (insert, contains, prefix_search), **ring buffer**, **sorted list**, **bag** (multiset), **sliding window** and **view** (zero-copy). |
| **Algo & number primitives** | **binary_search**, **lower_bound**, **upper_bound**, **prefix_sum**, **kadane**, **merge_sorted**, **sliding_window**, **two_pointers_sum**, **flood_fill**. **gcd**/lcm, **stats** (mean, variance), **bits** (popcount, etc.). **memo(f)** memoizes a one-arg function. |
| **Security in the type system** | Declare with **enc** or **secret**; values are stored encrypted or redacted in logs. First-class **Encrypted** and **Secret** in the runtime. |

---

## Install

### Windows

Download the installer from [Releases](https://github.com/Llunarstack/j/releases) or build locally:

```powershell
cd jade-lang
cargo build --release
.\installers\windows\build-exe.ps1
# → dist\installers\windows\jade-1.0.0-windows-x86_64-setup.exe
```

### macOS / Linux

```bash
git clone https://github.com/Llunarstack/j.git
cd j/jade-lang
cargo build --release
./installers/linux/install.sh    # Linux
# or
./installers/macos/install.sh   # macOS
```

### From source (any OS)

```bash
cd jade-lang
cargo build --release
# Binary: target/release/jade
# Add to PATH or: cargo install --path .
```

More options (portable zip, MSI): **[docs/INSTALL.md](docs/INSTALL.md)**.

---

## Quick start

```bash
# Create a file
echo 'out("Hi from Jade!")' > hello.jdl

# Run it
jade hello.jdl
# → Hi from Jade!

# REPL
jade repl
```

---

## Project layout

| Path | What |
|------|------|
| [jade-lang/](jade-lang/) | Rust crate: interpreter, compiler, REPL, Jolt |
| [jade-lang/installers/](jade-lang/installers/) | Windows (Inno, MSI, portable), Linux, macOS |
| [docs/](docs/README.md) | [INSTALL](docs/INSTALL.md) · [CONTRIBUTING](docs/CONTRIBUTING.md) · [Structure](docs/PROJECT_STRUCTURE.md) |
| [bootstrap/](bootstrap/) | Jade written in Jade: scripts that process Jade source |

---

## Documentation

- **Install & run:** [docs/INSTALL.md](docs/INSTALL.md)
- **Contributing:** [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) · [Code of Conduct](docs/CODE_OF_CONDUCT.md)
- **Changelog:** [CHANGELOG.md](CHANGELOG.md)

---

## Contributing

Contributions are welcome. Open an [issue](https://github.com/Llunarstack/j/issues) or see [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md).

---

## License

MIT — see [LICENSE](LICENSE). The name and logo **Jade** are used for this project; to use them elsewhere, please [open an issue](https://github.com/Llunarstack/j/issues) to discuss.
