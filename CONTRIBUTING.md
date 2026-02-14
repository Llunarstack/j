# Contributing to J Language

Thank you for your interest in contributing to J! This document provides guidelines for contributing to the project.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/j.git`
3. Create a branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Test your changes: `cargo test`
6. Commit: `git commit -m "feat: your feature description"`
7. Push: `git push origin feature/your-feature-name`
8. Open a Pull Request

## Development Setup

### Prerequisites
- Rust 1.70 or higher
- Cargo
- Git

### Building
```bash
cd j-lang
cargo build
```

### Running Tests
```bash
cargo test
cargo test --all-features
```

### Code Style
```bash
cargo fmt
cargo clippy
```

## Project Structure

```
j/
├── j-lang/           # Core language implementation
│   ├── src/          # Source code
│   ├── tests/        # Integration tests
│   ├── examples/     # Example programs
│   └── lib/          # Standard library
├── LICENSE           # MIT License
└── README.md         # Project overview
```

## Commit Message Guidelines

We follow conventional commits:

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

Example: `feat: add async/await support`

## Code Guidelines

### Rust Code
- Follow Rust naming conventions
- Add documentation comments for public APIs
- Write tests for new features
- Keep functions focused and small
- Use meaningful variable names

### J Language Code
- Use clear, descriptive names
- Add comments for complex logic
- Follow the style guide in examples
- Test your code before submitting

## Testing

### Writing Tests
- Add unit tests in the same file as the code
- Add integration tests in `j-lang/tests/`
- Add example programs in `j-lang/examples/`

### Running Specific Tests
```bash
cargo test test_name
cargo test --test integration_test_name
```

## Pull Request Process

1. Update documentation if needed
2. Add tests for new features
3. Ensure all tests pass
4. Update CHANGELOG.md
5. Request review from maintainers

### PR Checklist
- [ ] Tests pass locally
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Commit messages follow guidelines

## Reporting Issues

### Bug Reports
Include:
- J version
- Operating system
- Steps to reproduce
- Expected vs actual behavior
- Code sample if applicable

### Feature Requests
Include:
- Clear description
- Use cases
- Example syntax (if applicable)
- Why it would be useful

## Questions?

- Open an issue for questions
- Check existing issues first
- Be respectful and constructive

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
