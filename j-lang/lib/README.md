# J Language Standard Library

Standard library modules for the J programming language.

## Structure

- **std/** - Core standard library (automatically imported)
- **math/** - Mathematical functions
- **collections/** - Collection utilities (list, dict, set)
- **io/** - Input/output operations

## Usage

```j
// Import a library module
import math.basic { abs, max, min }

// Use imported functions
int | result -> abs(-42)
out(result)  // 42
```

## Available Modules

### std/prelude.j
Core types and constants, automatically available.

### math/basic.j
- `abs(x)` - Absolute value
- `max(a, b)` - Maximum of two numbers
- `min(a, b)` - Minimum of two numbers
- `pow(base, exp)` - Power function

### collections/list.j
- `map_list(items, fn)` - Map function over list
- `filter_list(items, fn)` - Filter list by predicate
- `reduce_list(items, initial, fn)` - Reduce list to single value

### io/file.j
- `read_file(path)` - Read file contents
- `write_file(path, content)` - Write to file
- `file_exists(path)` - Check if file exists
