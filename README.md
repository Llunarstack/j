# J Programming Language

A modern, type-safe programming language designed for simplicity, safety, and performance. J combines the best features from multiple programming paradigms with a clean, explicit syntax.

## Features

### Core Language Features
- **Explicit Type Declarations**: `type | name -> value` syntax
- **Immutable by Default**: Use `!type` for constants
- **Rich Type System**: int, float, str, bool, char, emoji, money, hex, date, time, datetime, infinity
- **Advanced Collections**: list, tuple, dict, vec, mat, set, deque, counter, priorityq, graph
- **Enums with Accessors**: `.label`, `.name`, `.value` properties
- **Classes**: Object-oriented programming with inheritance support
- **Pattern Matching**: Powerful match expressions
- **Pipeline Operator**: `|>` for functional composition
- **Lambda Functions**: Both `fn x > expr` and `x => expr` syntax

### Loop Variants
- Basic iteration: `i in collection : body`
- Indexed: `(i, v) in collection : body`
- Range: `i in 0..10 : body`
- With step: `i in 0..100 by 10 : body`
- Nested loops with clean syntax

### Built-in Functions (200+)
- Collection operations: map, filter, reduce, zip, enumerate, flatten
- Math functions: sqrt, sin, cos, log, abs, min, max, sum
- String operations: split, join, trim, replace, search
- Set operations: union, intersect, difference, symmetric_diff
- Graph algorithms: BFS, DFS, Dijkstra
- Advanced: FFT, convex hull, permutations, combinations

### Rich Output
- Colored text output
- Progress bars
- Tables with formatting
- Animations (spinner, dots, bounce)
- Gradient text

### Decorators
- `@memo`: Memoization
- `@tco`: Tail call optimization
- `@timer`: Execution timing
- `@log_call`: Function call logging

## Installation

### Prerequisites
- Rust toolchain (1.70+)
- Cargo

### Build from Source
```bash
cd j-lang
cargo build --release
```

The compiled binary will be at `j-lang/target/release/j.exe` (Windows) or `j-lang/target/release/j` (Unix).

## Usage

### Run the REPL
```bash
j repl
```

### Run a J file
```bash
j run myprogram.j
```

### Compile to native binary (AOT)
```bash
j build myprogram.j --release -o myapp
```

### Check syntax
```bash
j check myprogram.j
```

## Syntax Examples

### Variables
```j
# Basic types
int | count -> 42
str | name -> "Alice"
bool | active -> true
float | pi -> 3.14159

# Immutable
!int | MAX_SIZE -> 1000

# Collections
list | nums -> [1, 2, 3, 4, 5]
dict | config -> { "host": "localhost", "port": 8080 }
```

### Functions
```j
fn int | add (int | a, int | b) > {
    a + b
}

# Lambda
square -> fn x > x * x

# Arrow lambda
double -> x => x * 2
```

### Classes
```j
class | Person {
    str | name -> "Unknown"
    int | age -> 0
    
    fn | greet () > {
        out("Hello, I am " name)
    }
}

# Create instance
person -> Person.new("Alice", 30)
```

### Enums
```j
enum | Status {
    Pending = 0
    Active = 1
    Complete = 2
}

out(Status[1].name)  # "Active"
```

### Loops
```j
# Simple iteration
i in [1, 2, 3, 4, 5] : out(i)

# With index
(i, v) in nums : out("[" i "] = " v)

# Range
i in 0..10 : out(i)

# Nested
r in rows : c in cols : out(r c)
```

### Pattern Matching
```j
match value {
    0 : out("zero")
    1 : out("one")
    x if x > 10 : out("big")
    _ : out("other")
}
```

### Pipeline
```j
[1, 2, 3, 4, 5]
    |> map(fn x > x * 2)
    |> filter(fn x > x > 5)
    |> sum()
    |> out(_)
```

## Project Structure

```
j-lang/
├── src/
│   ├── main.rs          # CLI entry point
│   ├── lexer.rs         # Tokenization
│   ├── parser.rs        # AST generation
│   ├── interpreter.rs   # Runtime execution
│   ├── compiler.rs      # AOT compilation
│   ├── jit.rs          # JIT compilation
│   ├── runtime.rs       # Runtime support
│   ├── repl.rs         # Interactive REPL
│   ├── jolt.rs         # Package manager
│   └── error.rs        # Error handling
├── examples/           # Example programs
└── Cargo.toml         # Rust dependencies
```

## Current Status

### ✅ Implemented
- Complete lexer and parser
- Full interpreter with 200+ built-in functions
- All basic types and collections
- For loops (all variants)
- Enums with accessors
- Pattern matching
- Error handling (try/catch)
- Rich output (colors, tables, animations)
- Decorators (@memo, @tco, @timer, @log_call)
- Lambda functions (both syntaxes)
- Pipeline operator
- Classes (declaration and basic structure)

### 🔨 In Progress
- Class instantiation (ClassName.new())
- Method calls on instances
- Inheritance implementation
- Advanced loop types (converge, fuzz, within, rollback, window, flood)
- Grid type for 2D algorithms
- Async/concurrency features

### 📋 Planned
- Module system and imports
- Foreign function interface (Python, JS, C)
- Advanced security features (untrusted, secret types)
- Enterprise features (DI, observability)
- AI/ML primitives
- Critical systems features (formal verification, audit)

## Documentation

See the following files for more information:
- `j.txt` - Complete language specification (7413 lines)
- `jnew_features.txt` - Advanced features specification
- `MISSING_FEATURES_SUMMARY.txt` - Implementation roadmap
- `IMPLEMENTATION_STATUS.txt` - Current implementation status

## Examples

Check the `j-lang/examples/` directory for sample programs:
- `basic.j` - Basic syntax examples
- `advanced.j` - Advanced features
- `file_execution.j` - File I/O operations
- `utils.j` - Utility functions

## Contributing

This is an active development project. The language specification is comprehensive and implementation is ongoing.

## License

[To be determined]

## Motto

**"Simple. Safe. God-mode."**

J is designed to be:
- **Simple**: Clean, explicit syntax with minimal noise
- **Safe**: Type-safe with strong error handling
- **God-mode**: Powerful features that make complex tasks trivial
