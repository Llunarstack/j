# Get Started with J Language

Welcome to J! This guide will get you up and running in minutes.

## 📦 Step 1: Install J

### Windows

Open PowerShell and run:

```powershell
cd j-lang\installers
.\install.ps1
```

Restart your terminal or refresh PATH:

```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','User')
```

### Linux/macOS

Open terminal and run:

```bash
cd j-lang/installers
chmod +x install.sh
./install.sh
```

Restart your terminal or source config:

```bash
source ~/.bashrc  # or ~/.zshrc for zsh
```

## ✅ Step 2: Verify Installation

```bash
j --version
```

You should see: `j 0.1.0`

## 🎮 Step 3: Try the REPL

Start the interactive REPL:

```bash
j repl
```

Try some commands:

```j
> int | x -> 42
> out(x)
42

> str | greeting -> "Hello, J!"
> out(greeting)
Hello, J!

> int | sum -> x + 10
> out(sum)
52
```

Type `exit` to quit.

## 📝 Step 4: Write Your First Program

Create a file called `hello.j`:

```j
# hello.j - My first J program

str | greeting -> "Hello, World!"
out(greeting)

int | x -> 42
int | y -> 10
int | sum -> x + y

out("The sum is: " + str(sum))
```

Run it:

```bash
j run hello.j
```

Output:
```
Hello, World!
The sum is: 52
```

## 🚀 Step 5: Explore Examples

J comes with many examples:

**Windows:**
```powershell
cd %LOCALAPPDATA%\J\examples
j run basic.j
j run math_utils.j
```

**Linux/macOS:**
```bash
cd ~/.j/examples
j run basic.j
j run math_utils.j
```

## 📚 Step 6: Learn More

### Basic Syntax

**Variables:**
```j
int | x -> 42
str | name -> "Alice"
bool | flag -> true
float | pi -> 3.14
```

**Functions:**
```j
fn add(int | a, int | b) -> int {
    return a + b
}

int | result -> add(5, 3)
out(result)  # 8
```

**Control Flow:**
```j
if x > 10 {
    out("x is large")
} else {
    out("x is small")
}

for i in range(0, 5) {
    out(i)
}
```

**Collections:**
```j
list<int> | numbers -> [1, 2, 3, 4, 5]
map<str, int> | ages -> {"Alice": 30, "Bob": 25}

out(numbers[0])      # 1
out(ages["Alice"])   # 30
```

### Commands

```bash
j repl              # Start interactive REPL
j run <file>        # Run a J program
j build <file>      # Compile to native binary
j check <file>      # Check syntax
j jolt init <name>  # Create new project
j jolt add <pkg>    # Add dependency
j --version         # Show version
j --help            # Show help
```

## 🎯 Step 7: Create a Project

Create a new project with Jolt (J's package manager):

```bash
j jolt init my-project
cd my-project
```

This creates:
```
my-project/
├── jolt.toml       # Project configuration
├── main.j          # Main program
└── src/            # Source files
```

Edit `main.j`:

```j
# main.j

fn main() {
    out("Welcome to my J project!")
}

main()
```

Run it:

```bash
j run main.j
```

## 🔧 Step 8: Install VS Code Extension

For the best development experience:

1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Search for "J Language"
4. Click Install

Features:
- Syntax highlighting
- 40+ code snippets
- IntelliSense
- Run & debug
- REPL integration

## 📖 Documentation

- **Installation Guide**: `j-lang/installers/README.md`
- **Language Features**: `docs/NEW_FEATURES_ADDED.md`
- **Module System**: `docs/MODULE_SYSTEM_COMPLETE.md`
- **VS Code Extension**: `docs/VSCODE_EXTENSION_COMPLETE.md`
- **Examples**: `j-lang/examples/`

## 🆘 Need Help?

### Troubleshooting

**"j is not recognized" (Windows)**
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','User')
```

**"command not found: j" (Linux/macOS)**
```bash
source ~/.bashrc  # or ~/.zshrc
```

**Still not working?**
See the troubleshooting section in `j-lang/installers/README.md`

### Get Support

- **Documentation**: `docs/` folder
- **Examples**: `j-lang/examples/` folder
- **Issues**: https://github.com/j-lang/j/issues
- **Discord**: https://discord.gg/j-lang

## 🎉 You're Ready!

You now have J installed and know the basics. Here's what to do next:

1. ✅ Explore the examples
2. ✅ Read the documentation
3. ✅ Build something cool
4. ✅ Share your projects
5. ✅ Join the community

**Happy coding with J!** 🚀

---

**Quick Reference**

```bash
# Install
cd j-lang/installers && ./install.ps1  # Windows
cd j-lang/installers && ./install.sh   # Linux/macOS

# Verify
j --version

# REPL
j repl

# Run
j run hello.j

# Create project
j jolt init my-project

# Help
j --help
```

---

**Version**: 0.1.0  
**Last Updated**: February 13, 2026
