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

Jade is a **memory-safe**, **readable** language and toolchain for data and algorithms. One binary: interpreter, REPL, and the **Jolt** package manager. No runtime dependency—ship a single executable.

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
| **Pipelines & pattern matching** | Thread values with `\|>`. Match on structure with `cond` and `when`. Lambdas and typed variables without boilerplate. |
| **Built for algorithms** | **Graphs** in the box: `bfs`, `dfs`, `dijkstra`, `topological_sort`. **Deques** and **priority queues**. **Union-find** and **tries**. Binary search helpers: `lower_bound`, `upper_bound`, `prefix_sum`, **Kadane**, `merge_sorted`, `sliding_window`, `two_pointers_sum`, `flood_fill`. |
| **Number crunching** | `gcd`/`lcm`, `min`/`max`, **stats** (mean, variance, etc.), **bits** (popcount, leading zeros). **Memoization** for one-arg functions. |
| **Lists that feel right** | List comprehensions, `map`/`filter`/`reduce`/`zip`, `range`. Mutable or build-new style. |
| **One binary, many modes** | Run a script (`jade file.jdl`), drop into the **REPL** (`jade repl`), or use **Jolt** for projects with a `jade.toml` and dependencies. Optional AOT compile and JIT. |

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
| [docs/](docs/README.md) | [INSTALL](docs/INSTALL.md) · [BOOTSTRAP](docs/BOOTSTRAP.md) · [CONTRIBUTING](docs/CONTRIBUTING.md) · [Structure](docs/PROJECT_STRUCTURE.md) |
| [bootstrap/](bootstrap/) | Jade scripts that process Jade source (bootstrapping) |

---

## Documentation

- **Install & run:** [docs/INSTALL.md](docs/INSTALL.md)
- **Bootstrapping:** [docs/BOOTSTRAP.md](docs/BOOTSTRAP.md)
- **Contributing:** [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) · [Code of Conduct](docs/CODE_OF_CONDUCT.md)
- **Changelog:** [CHANGELOG.md](CHANGELOG.md)

---

## Contributing

Contributions are welcome. Open an [issue](https://github.com/Llunarstack/j/issues) or see [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md).

---

## License

MIT — see [LICENSE](LICENSE). The name and logo **Jade** are used for this project; to use them elsewhere, please [open an issue](https://github.com/Llunarstack/j/issues) to discuss.
