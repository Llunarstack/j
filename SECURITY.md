# Security policy

## Supported versions

| Version | Supported          |
|---------|--------------------|
| 0.1.x   | :white_check_mark: |

## Reporting a vulnerability

Please **do not** open a public issue for security vulnerabilities.

- **Email:** Report to the maintainers (e.g. via GitHub account contact if available, or open a **private** security advisory).
- **GitHub:** Use [Security → Advisories → Report a vulnerability](https://github.com/Llunarstack/j/security/advisories/new).

Include:

- Description of the vulnerability and impact
- Steps to reproduce
- Suggested fix (if any)
- Your preference for credit (e.g. in release notes)

We will respond as soon as possible and will work with you on disclosure timing.

## Security considerations

- J is an experimental language; the interpreter and standard library are not yet hardened for production or untrusted input.
- Avoid running untrusted `.j` code in sensitive environments.
- Cryptography features (e.g. in `crypto.rs`) are for demonstration and experimentation; use established libraries for real security needs.
