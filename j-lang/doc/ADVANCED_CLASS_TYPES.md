# Advanced Class Types Implementation Plan

## Overview
J supports 7 special class types that provide powerful built-in behaviors:

1. **secure class** - Encrypted fields by default
2. **singleton class** - Only one instance ever
3. **actor class** - Simplified actor model (message passing)
4. **observable class** - Reactive/event-driven
5. **threadsafe class** - Automatic mutex protection
6. **data class** - Value type with auto-equals/hash/copy
7. **resource class** - RAII-style auto-cleanup

## Implementation Status

### ✅ Already Implemented
- Lexer tokens: `Secure`, `Singleton`, `Actor`, `Observable`, `Threadsafe`, `Data`, `Resource`
- Parser: Recognizes `<type> class | Name { ... }` syntax
- AST: `ClassDeclaration` has `class_type: Option<String>` field
- Value enum: `Class` variant has `class_type` field

### 🔨 Needs Implementation

#### 1. Secure Class
**Behavior**: All fields encrypted at rest, auto-decrypt on access
```j
secure class | Vault {
  enc<str> | master_password_hash
  enc<dict> | secrets
}
```
**Implementation**:
- Fields marked with `enc<T>` are automatically encrypted
- Access requires decryption key validation
- Store encrypted values in `Value::Encrypted`

#### 2. Singleton Class
**Behavior**: Only one instance exists globally
```j
singleton class | AppConfig {
  dict | settings -> { theme: "dark" }
}
```
**Implementation**:
- Add `singleton_registry: HashMap<String, Value>` to Interpreter
- On instantiation, check registry first
- Return existing instance or create new one

#### 3. Actor Class
**Behavior**: Message queue, serialized execution
```j
actor class | Counter {
  int | count -> 0
  fn inc() > count = count + 1
}
```
**Implementation**:
- Wrap instance in message queue
- Method calls become messages
- Process messages sequentially
- Return futures/promises for async results

#### 4. Observable Class
**Behavior**: Auto-notify subscribers on field changes
```j
observable class | Sensor {
  float | value -> 22.5
  on_change | listeners -> []
  fn set(float | v) > value = v  # triggers listeners
}
```
**Implementation**:
- Track field watchers
- Intercept field assignments
- Call registered callbacks on change

#### 5. Threadsafe Class
**Behavior**: Automatic mutex protection
```j
threadsafe class | Cache {
  dict | data -> {}
  fn get(str | k) > data[k]
}
```
**Implementation**:
- Wrap instance in Arc<Mutex<>>
- Auto-lock on method entry
- Auto-unlock on method exit

#### 6. Data Class
**Behavior**: Value semantics with auto-generated methods
```j
data class | Point {
  float | x, y, z -> 0, 0, 0
}
```
**Implementation**:
- Auto-generate: `==`, `.hash()`, `.copy()`, `.to_str()`
- Implement structural equality
- Make copyable by default

#### 7. Resource Class
**Behavior**: RAII-style cleanup
```j
resource class | DBConn {
  fn new(str | url) > { /* connect */ }
  fn close() > { /* disconnect */ }
}
```
**Implementation**:
- Track resource instances
- Call `.close()` on scope exit
- Handle panics/errors gracefully

## Implementation Priority

1. **singleton** - Simplest, high value
2. **data** - Common use case, straightforward
3. **resource** - RAII is powerful
4. **secure** - Builds on existing encryption
5. **threadsafe** - Requires concurrency primitives
6. **observable** - Requires event system
7. **actor** - Most complex, requires message passing

## Next Steps

1. Implement singleton registry in Interpreter
2. Add data class auto-methods
3. Implement resource cleanup tracking
4. Add secure class encryption enforcement
5. Build threadsafe wrapper
6. Create observable notification system
7. Implement actor message queue
