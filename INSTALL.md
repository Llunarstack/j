# Install J Language

Quick installation guide for the J programming language.

## Windows

```powershell
cd j-lang\installers
.\install.ps1
```

Then restart your terminal or run:
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','User')
```

## Linux/macOS

```bash
cd j-lang/installers
chmod +x install.sh
./install.sh
```

Then restart your terminal or run:
```bash
source ~/.bashrc  # or ~/.zshrc
```

## Verify

```bash
j --version
j repl
```

## Uninstall

**Windows:**
```powershell
.\install.ps1 -Uninstall
```

**Linux/macOS:**
```bash
./install.sh --uninstall
```

## Full Documentation

See `j-lang/installers/README.md` for complete installation guide.

## Support

- Documentation: `docs/` folder
- Examples: `j-lang/examples/` folder
- Issues: https://github.com/j-lang/j/issues
