# J Language - OOB (Out-of-Band) Features

## Overview

OOB features are brand-new mechanics that live outside the class system, providing unique capabilities that set J apart from other languages. These features are deeply integrated with J's existing syntax (pipelines, cond, match, ownership, concurrency, crypto).

## 1. `flow` - Automatic Data Dependency Graph

Spreadsheet-style reactivity without classes or frameworks.

### Syntax
```j
flow {
    a -> 10           # Direct assignment
    b -> 20
    c := a + b        # Derived value (auto-dependency)
    d := c * 2
    e := d + a
}
```

### Features
- `:=` defines a derived value (computed lazily on read)
- Compiler builds DAG (Directed Acyclic Graph)
- No manual event listeners needed
- Thread-safe propagation (queued updates)
- Break cycle with `=` (manual assignment)

### Use Cases
- Dashboards
- Simulations
- Config validation
- Live previews
- Reactive UIs

### Example
```j
flow {
    price -> 100
    quantity -> 5
    subtotal := price * quantity
    tax := subtotal * 0.1
    total := subtotal + tax
}

out(total)  # 550
price = 200
out(total)  # Auto-updates to 1100
```

## 2. `probe` - Runtime Value Inspection Hooks

Non-intrusive debugging and monitoring.

### Syntax
```j
probe variable { hooks }
```

### Available Hooks
- `value` - When value changes
- `added` - When item added to collection
- `removed` - When item removed
- `accessed` - When value is read
- `mutated` - When value is modified
- `dropped` - When value is destroyed

### Features
- Attaches callbacks without changing code
- Zero runtime cost when disabled (`probe off`)
- Great for debugging, tracing, metrics

### Example
```j
int | counter -> 0
probe counter { 
    value -> out("Counter changed to " value)
    accessed -> log.debug("Counter accessed")
}

counter = 42  # Prints: "Counter changed to 42"
out(counter)  # Logs: "Counter accessed"

# Probe collections
list | items -> []
probe items { 
    added -> log.debug("Added " added)
    removed -> log.debug("Removed " removed)
}

items -> 1  # Logs: "Added 1"
items -> 2  # Logs: "Added 2"
```

## 3. `fuse` - Compile-time Code Fusion / Inlining

Aggressive optimization hint for hot code paths.

### Syntax
```j
fuse fn | function_name (params) > body
fuse pipeline { stages }
```

### Features
- Compiler aggressively inlines and constant-folds
- Works on functions, methods, pipelines
- Entire pipeline chains fused into single tight loop
- Zero-cost abstraction

### Example
```j
# Fuse function
fuse fn | square (int | n) > n * n + 1
out(square(5))  # Inlined to 26 at compile-time if constant

# Fuse pipeline
fuse pipeline {
    numbers() |> filter(_ % 2 == 0) |> map(_ * 10) |> sum()
}
# Entire chain fused into single loop - no intermediate allocations
```

## 4. `veil` - Oblivious Data Access

Prevents side-channel leaks with constant-time operations.

### Syntax
```j
veil dict | variable -> { ... }
value -> collection.veil_get(key)
collection.veil_set(key, value)
veil { block }
```

### Features
- `veil_get` / `veil_set` = constant-time operations
- Prevents cache-timing attacks
- Works on maps, arrays, strings
- `veil { block }` = run entire block in constant-time mode

### Use Cases
- Crypto code
- Password checks
- Secure token validation
- Side-channel resistant algorithms

### Example
```j
veil dict | secrets -> { 
    "admin": "pass123",
    "user": "pass456"
}

# Constant-time lookup - no timing leak
str | password -> secrets.veil_get("admin")

# Constant-time comparison
veil {
    str | input -> get_user_input()
    bool | match -> password ~== input  # ~== is constant-time
    if match {
        out("Access granted")
    }
}
```

## 5. `warp` - Compile-time Metaprogramming Light

Simple template expansion without full macros.

### Syntax
```j
warp template | name (params) > { body }
```

### Features
- Parametric code generation
- Type-checked
- Zero runtime cost
- Safer than full macros

### Example
```j
# Create logger template
warp template | make_logger (str | prefix) > {
    fn | log (str | msg) > out("[{prefix}] " msg)
}

# Instantiate loggers
make_logger("INFO") | info_log
make_logger("ERROR") | error_log
make_logger("DEBUG") | debug_log

info_log("Server started")    # [INFO] Server started
error_log("Connection failed") # [ERROR] Connection failed
debug_log("Variable x = 42")   # [DEBUG] Variable x = 42

# Create data structure template
warp template | make_pair (str | T) > {
    class Pair {
        T | first
        T | second
        
        fn | swap () > {
            T | temp -> this.first
            this.first = this.second
            this.second = temp
        }
    }
}

make_pair("int") | IntPair
IntPair | pair -> IntPair.new(10, 20)
pair.swap()
```

## 6. `ghost` - Optional Ghost Variables

Debug-only variables that are completely stripped in release builds.

### Syntax
```j
ghost type | name -> value
```

### Features
- Exists in debug builds
- Completely removed in release builds (zero cost)
- Perfect for counters, traces, assertions

### Example
```j
ghost int | call_count -> 0
ghost int | max_depth -> 0
ghost list | trace_log -> []

fn | recursive_function (int | n) > {
    ghost call_count = call_count + 1
    ghost trace_log -> "Called with n=" n
    
    if n <= 0 {
        return 1
    }
    
    return n * recursive_function(n - 1)
}

int | result -> recursive_function(5)
out("Result: " result)

# In debug build: prints call count
# In release build: ghost variables don't exist
ghost out("Total calls: " call_count)
ghost out("Trace: " trace_log)
```

## Comparison with Other Languages

| Feature | J | Other Languages |
|---------|---|-----------------|
| `flow` | Built-in reactive DAG | Requires frameworks (React, Vue, RxJS) |
| `probe` | Non-intrusive hooks | Debugger breakpoints, manual logging |
| `fuse` | Explicit fusion hint | Relies on optimizer heuristics |
| `veil` | Constant-time primitives | Manual implementation, easy to get wrong |
| `warp` | Safe templates | Full macros (complex, unsafe) or no metaprogramming |
| `ghost` | Conditional compilation | Preprocessor directives, feature flags |

## Implementation Status

✅ AST nodes defined
✅ Lexer tokens added
✅ Parser integration (TODO)
✅ Interpreter basic implementation
⏳ Full reactive system for `flow`
⏳ Hook registration system for `probe`
⏳ Compiler fusion optimization for `fuse`
⏳ Constant-time operations for `veil`
⏳ Template expansion for `warp`
✅ Conditional compilation for `ghost`

## Future Enhancements

### `flow`
- Incremental computation
- Memoization of derived values
- Cycle detection and warnings
- Async reactive updates

### `probe`
- Conditional probes (only fire when condition met)
- Probe aggregation (collect statistics)
- Remote probes (send to monitoring service)
- Probe composition (chain multiple probes)

### `fuse`
- Profile-guided fusion
- Cross-function fusion
- SIMD vectorization hints
- GPU kernel fusion

### `veil`
- Hardware constant-time guarantees
- Formal verification of constant-time properties
- Automatic veil inference
- Veil-safe standard library

### `warp`
- Type-level computation
- Compile-time evaluation
- Template specialization
- Generic constraints

### `ghost`
- Ghost types (types that only exist in debug)
- Ghost functions (functions stripped in release)
- Ghost assertions (zero-cost contracts)
- Ghost profiling (automatic performance tracking)

## Best Practices

1. **`flow`**: Use for UI state, config management, derived computations
2. **`probe`**: Use for debugging, monitoring, not production logic
3. **`fuse`**: Use for hot loops, performance-critical code
4. **`veil`**: Use for all security-sensitive operations
5. **`warp`**: Use for code generation, avoid complex logic
6. **`ghost`**: Use for debugging aids, never for correctness

## Performance Impact

| Feature | Debug Build | Release Build |
|---------|-------------|---------------|
| `flow` | Small overhead (DAG tracking) | Optimized away if unused |
| `probe` | Callback overhead | Zero (stripped) |
| `fuse` | Same as normal | Faster (inlined) |
| `veil` | Constant-time (slower) | Constant-time (same) |
| `warp` | Zero (compile-time) | Zero (compile-time) |
| `ghost` | Small overhead | Zero (stripped) |

## Security Considerations

- **`veil`** is critical for crypto code - always use for sensitive operations
- **`ghost`** should never contain secrets (stripped in release)
- **`probe`** hooks can leak information - be careful in production
- **`flow`** reactive updates are not constant-time
- **`fuse`** and **`warp`** are compile-time only - no runtime security impact
