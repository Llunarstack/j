# J Language Extension for Visual Studio Code

Official VS Code extension for the J Programming Language.

## Features

### 🎨 Syntax Highlighting
- Full syntax highlighting for J language
- Support for all J keywords, types, and operators
- Custom color themes (J Dark and J Light)

### ✂️ Code Snippets
- 40+ code snippets for common patterns
- Variable declarations (`int`, `str`, `list`, `dict`)
- Function definitions (`fn`, `fnt`, `lambda`)
- Control flow (`if`, `for`, `while`, `match`)
- Classes and traits
- Async/await patterns
- Decorators (`@memo`, `@once`, `@test`)
- And much more!

### 🚀 Run & Debug
- Run J files directly from VS Code (`Ctrl+Shift+R`)
- Start J REPL (`Ctrl+Shift+I`)
- View output in integrated terminal
- Syntax checking on save

### 🔍 IntelliSense
- Auto-completion for keywords
- Type suggestions after `|`
- Built-in function documentation
- Hover information for functions

### 🛠️ Commands
- **J: Run Current File** - Execute the current J file
- **J: Start REPL** - Open J REPL in terminal
- **J: Check Syntax** - Validate syntax
- **J: Build Project** - Build J project
- **J: New Project** - Create new J project with Jolt
- **J: Format Document** - Format J code

### ⌨️ Keyboard Shortcuts
- `Ctrl+Shift+R` (Mac: `Cmd+Shift+R`) - Run current file
- `Ctrl+Shift+I` (Mac: `Cmd+Shift+I`) - Start REPL
- `Ctrl+Shift+F` (Mac: `Cmd+Shift+F`) - Format document

### 🎨 Themes
- **J Dark** - Dark theme optimized for J
- **J Light** - Light theme optimized for J

## Installation

### From VS Code Marketplace
1. Open VS Code
2. Go to Extensions (`Ctrl+Shift+X`)
3. Search for "J Language"
4. Click Install

### From VSIX File
1. Download `j-lang-0.1.0.vsix`
2. Open VS Code
3. Go to Extensions
4. Click "..." menu → "Install from VSIX"
5. Select the downloaded file

## Requirements

- J Language installed on your system
- J executable in PATH or configured in settings

## Extension Settings

This extension contributes the following settings:

* `j-lang.executablePath`: Path to J executable (default: `j`)
* `j-lang.enableLinting`: Enable syntax checking (default: `true`)
* `j-lang.formatOnSave`: Format document on save (default: `false`)
* `j-lang.showOutputOnRun`: Show output panel when running files (default: `true`)

## Usage

### Running J Files

1. Open a `.j` file
2. Press `Ctrl+Shift+R` or click the play button in the title bar
3. View output in the "J Language" output panel

### Using Snippets

Type a snippet prefix and press `Tab`:

```j
# Type "fn" and press Tab
fn | myFunction (int | x) > {
  # function body
  return_value
}

# Type "int" and press Tab
int | myVar -> 0

# Type "for" and press Tab
for item in list {
  # code
}
```

### Starting REPL

1. Press `Ctrl+Shift+I`
2. Or run command: "J: Start REPL"
3. REPL opens in integrated terminal

### Creating New Project

1. Run command: "J: New Project"
2. Enter project name
3. Select parent folder
4. Project is created with Jolt

## Snippets Reference

### Variables
- `var` - Variable declaration
- `int` - Integer variable
- `str` - String variable
- `list` - List variable
- `dict` - Dictionary variable

### Functions
- `fn` - Function definition
- `fnt` - Function with return type
- `lambda` - Lambda function
- `async` - Async function

### Control Flow
- `if` - If statement
- `ife` - If-else statement
- `for` - For loop
- `while` - While loop
- `match` - Match statement

### Classes & Traits
- `class` - Class definition
- `trait` - Trait definition
- `module` - Module definition

### Decorators
- `deco` - Decorated function
- `memo` - Memoized function
- `once` - Once decorator

### Advanced
- `window` - Window loop
- `groupby` - Group by function
- `partition` - Partition function
- `counter` - Counter from list
- `grid` - Create grid

## Known Issues

- Formatter is basic (will be enhanced)
- Error parsing could be more detailed

## Release Notes

### 0.1.0

Initial release:
- Syntax highlighting
- 40+ code snippets
- Run & debug support
- IntelliSense
- REPL integration
- Project creation
- Custom themes

## Contributing

Found a bug or have a feature request? Please open an issue on [GitHub](https://github.com/j-lang/j).

## License

MIT License - See LICENSE file for details

---

**Enjoy coding in J!** 🚀
