# Contributing to J

Thank you for contributing to the J programming language. This guide will help you get started.

## Table of contents

- [Code of conduct](#code-of-conduct)
- [Getting started](#getting-started)
- [Development setup](#development-setup)
- [Making changes](#making-changes)
- [Submitting changes](#submitting-changes)
- [Reporting issues](#reporting-issues)

## Code of conduct

This project adheres to the [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold it.

## Getting started

1. **Fork** the repository on GitHub.
2. **Clone** your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/j.git
   cd j
   ```
3. **Create a branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```
   Use a short prefix: `feature/`, `fix/`, `docs/`, `refactor/`, `test/`.

## Development setup

### Prerequisites

- **Rust** 1.70 or higher  
  Install from [rustup.rs](https://rustup.rs).
- **Cargo** (included with Rust)
- **Git**

### Build and test

All commands below are run from the **`j-lang`** directory (the main crate).

```bash
cd j-lang
cargo build
cargo test
```

### Code quality

```bash
cargo fmt
cargo clippy
```

CI runs `cargo fmt --check`, `cargo clippy`, and `cargo test` on push and pull requests.

### Project structure

| Purpose        | Path               |
|----------------|--------------------|
| Source         | `j-lang/src/`      |
| Standard lib   | `j-lang/stdlib/`   |
| Documentation  | `j-lang/doc/`      |
| Examples       | `j-lang/examples/` |
| Tests          | `j-lang/tests/`    |

See [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for the full layout.

## Making changes

### Commit messages

Use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation only
- `style:` Formatting, no logic change
- `refactor:` Code change that is not a fix or feature
- `test:` Adding or updating tests
- `chore:` Build, tooling, or maintenance

Example: `feat: add pipeline operator for list comprehensions`

### Code guidelines

- **Rust:** Follow standard naming and style. Add doc comments for public APIs. Prefer small, focused functions.
- **J code (examples/tests):** Use clear names and comments; keep examples runnable.

## Submitting changes

1. Ensure tests pass and the code is formatted:
   ```bash
   cd j-lang && cargo fmt && cargo clippy && cargo test
   ```
2. Update **CHANGELOG.md** for user-visible changes.
3. Push your branch and open a **Pull Request** against `main` (or `master`).
4. Fill out the [PR template](.github/PULL_REQUEST_TEMPLATE.md) and link any related issues.

Maintainers will review and may request changes. Once approved, your PR can be merged.

## Reporting issues

- **Bugs:** Use the [Bug report](https://github.com/Llunarstack/j/issues/new?template=bug_report.md) template.
- **Features:** Use the [Feature request](https://github.com/Llunarstack/j/issues/new?template=feature_request.md) template.
- **Security:** See [SECURITY.md](SECURITY.md); do not report vulnerabilities in public issues.

Include version, OS, and minimal steps or code to reproduce where relevant.

## Questions

- Search [existing issues](https://github.com/Llunarstack/j/issues) first.
- Open a new issue for questions or discussions.
- Be respectful and constructive.

---

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
