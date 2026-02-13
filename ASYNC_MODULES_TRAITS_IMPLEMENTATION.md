# Full Implementation Guide: Async/Await, Modules, and Traits

## Executive Summary

The J language currently has **basic/placeholder implementations** for Async/Await, Modules, and Traits. This document provides a complete implementation roadmap to make these features fully functional.

---

## 1. MODULE SYSTEM - Full Implementation

### Current Status
✅ Module declaration parsing  
✅ Import statement parsing  
❌ No actual file loading  
❌ No export mechanism  
❌ No module caching  

### Implementation Steps

#### Step 1: Add Module Value Type
```rust
// In interpreter.rs Value enum
Module {
    name: String,
    path: String,
    exports: HashMap<String, Value>,  // exported items
    private: HashMap<String, Value>,  // private items
}
```

#### Step 2: Add Module Cache to Interpreter
```rust
// In Interpreter struct
module_cache: HashMap<String, Value>,  // path -> Module
module_search_paths: Vec<String>,      // [".", "./lib", "~/.j/packages"]
```

#### Step 3: Implement Module File Loader
```rust
fn load_module(&mut self, path: &str) -> Result<Value, String> {
    // Check cache first
    if let Some(cached) = self.module_cache.get(path) {
        return Ok(cached.clone());
    }
    
    // Resolve file path
    let file_path = self.resolve_module_path(path)?;
    
    // Read and parse file
    let source = std::fs::read_to_string(&file_path)
        .map_err(|e| format!("Failed to load module {}: {}", path, e))?;
    
    let lexer = Lexer::new(&source);
    let tokens = lexer.tokenize()?;
    let mut parser = Parser::new(tokens);
    let ast = parser.parse()?;
    
    // Execute in isolated scope
    self.push_scope();
    let mut exports = HashMap::new();
    
    // Track exports during execution
    self.current_module_exports = Some(&mut exports);
    self.eval_node(&ast)?;
    self.current_module_exports = None;
    
    self.pop_scope();
    
    // Create module value
    let module = Value::Module {
        name: path.to_string(),
        path: file_path,
        exports,
        private: HashMap::new(),
    };
    
    // Cache it
    self.module_cache.insert(path.to_string(), module.clone());
    
    Ok(module)
}
```

#### Step 4: Implement Export Keyword
```rust
// In eval_node
AstNode::ExportDeclaration { item } => {
    let value = self.eval_node(item)?;
    
    // If we're in a module, add to exports
    if let Some(exports) = &mut self.current_module_exports {
        if let AstNode::VarDeclaration { name, .. } = item.as_ref() {
            exports.insert(name.clone(), value.clone());
        } else if let AstNode::FunctionDeclaration { name, .. } = item.as_ref() {
            exports.insert(name.clone(), value.clone());
        }
    }
    
    Ok(value)
}
```

#### Step 5: Implement Import Resolution
```rust
AstNode::ImportStatement { module_path, items } => {
    let path = module_path.join("/");
    let module = self.load_module(&path)?;
    
    if let Value::Module { exports, .. } = module {
        if items.is_empty() {
            // Import all exports
            for (name, value) in exports {
                self.set_variable(name, value);
            }
        } else {
            // Import specific items
            for item in items {
                if let Some(value) = exports.get(item) {
                    self.set_variable(item.clone(), value.clone());
                } else {
                    return Err(format!("Module {} does not export '{}'", path, item));
                }
            }
        }
    }
    
    Ok(Value::None)
}
```

### Module Test Example
```j
// math.j
export fn | add(int | a, int | b) > a + b
export fn | multiply(int | a, int | b) > a * b
export int | PI -> 3.14159

fn | internal_helper() > {
    // Private function
}

// main.j
import "./math.j" { add, multiply, PI }

result -> add(5, 3)
out(result)  // 8
out(PI)      // 3.14159
```

---

## 2. TRAIT SYSTEM - Full Implementation

### Current Status
✅ Trait declaration parsing  
✅ Traits stored in environment  
❌ No implementation checking  
❌ No trait method dispatch  
❌ No trait bounds  

### Implementation Steps

#### Step 1: Add Trait Value Type
```rust
Trait {
    name: String,
    methods: Vec<TraitMethod>,
    parent_traits: Vec<String>,  // for trait inheritance
}

struct TraitMethod {
    name: String,
    params: Vec<(String, String)>,  // (type, name)
    return_type: Option<String>,
    default_impl: Option<Box<AstNode>>,
}
```

#### Step 2: Add Trait Implementation Storage
```rust
// In Interpreter struct
trait_impls: HashMap<String, HashMap<String, Value>>,  // type_name -> trait_name -> impl
```

#### Step 3: Parse Trait Implementation
```rust
// Add to parser.rs
AstNode::TraitImpl {
    trait_name: String,
    type_name: String,
    methods: Vec<AstNode>,
}

// In eval_node
AstNode::TraitImpl { trait_name, type_name, methods } => {
    // Get trait definition
    let trait_val = self.get_variable(&format!("__trait_{}", trait_name))?;
    
    // Verify all required methods are implemented
    let trait_methods = extract_trait_methods(&trait_val)?;
    let impl_methods: HashMap<String, Value> = methods.iter()
        .filter_map(|m| {
            if let AstNode::FunctionDeclaration { name, params, body, .. } = m {
                Some((name.clone(), Value::Function {
                    name: name.clone(),
                    params: params.iter().map(|(_, n)| n.clone()).collect(),
                    body: body.clone(),
                }))
            } else {
                None
            }
        })
        .collect();
    
    // Check all trait methods are implemented
    for trait_method in trait_methods {
        if !impl_methods.contains_key(&trait_method.name) {
            if trait_method.default_impl.is_none() {
                return Err(format!(
                    "Type {} must implement method {} from trait {}",
                    type_name, trait_method.name, trait_name
                ));
            }
        }
    }
    
    // Store implementation
    self.trait_impls
        .entry(type_name.clone())
        .or_insert_with(HashMap::new)
        .insert(trait_name.clone(), Value::Dict(impl_methods));
    
    Ok(Value::None)
}
```

#### Step 4: Trait Method Dispatch
```rust
fn call_trait_method(&mut self, obj: &Value, trait_name: &str, method_name: &str, args: &[Value]) -> Result<Value, String> {
    let type_name = get_type_name(obj);
    
    // Look up trait implementation
    if let Some(trait_impls) = self.trait_impls.get(&type_name) {
        if let Some(impl_val) = trait_impls.get(trait_name) {
            if let Value::Dict(methods) = impl_val {
                if let Some(method) = methods.get(method_name) {
                    return self.call_value_with_args(method.clone(), args, Some(obj.clone()));
                }
            }
        }
    }
    
    Err(format!("Type {} does not implement trait {}", type_name, trait_name))
}
```

### Trait Test Example
```j
// Define trait
trait | Drawable {
    fn | draw() > {}
    fn | get_color() > "black"  // default implementation
}

// Define class
class | Circle {
    float | radius -> 0.0
}

// Implement trait for class
impl Drawable for Circle {
    fn | draw() > {
        out("Drawing circle with radius: " + str(this.radius))
    }
    // get_color uses default implementation
}

// Use it
circle -> Circle.new()
circle.radius = 5.0
circle.draw()  // "Drawing circle with radius: 5.0"
out(circle.get_color())  // "black"
```

---

## 3. ASYNC/AWAIT - Full Implementation

### Current Status
✅ Async function parsing  
✅ Await expression parsing  
❌ No async runtime  
❌ No task scheduler  
❌ Synchronous execution only  

### Implementation Steps

#### Step 1: Add Future/Promise Value Type
```rust
Future {
    id: usize,
    state: FutureState,
    result: Option<Box<Value>>,
}

enum FutureState {
    Pending,
    Running,
    Completed,
    Failed(String),
}
```

#### Step 2: Add Async Runtime to Interpreter
```rust
// In Interpreter struct
async_runtime: Option<AsyncRuntime>,
futures: HashMap<usize, Future>,
next_future_id: usize,
```

#### Step 3: Implement Async Runtime
```rust
struct AsyncRuntime {
    executor: tokio::runtime::Runtime,
    tasks: HashMap<usize, tokio::task::JoinHandle<Result<Value, String>>>,
}

impl AsyncRuntime {
    fn new() -> Self {
        Self {
            executor: tokio::runtime::Runtime::new().unwrap(),
            tasks: HashMap::new(),
        }
    }
    
    fn spawn<F>(&mut self, future: F) -> usize
    where
        F: std::future::Future<Output = Result<Value, String>> + Send + 'static,
    {
        let id = self.tasks.len();
        let handle = self.executor.spawn(future);
        self.tasks.insert(id, handle);
        id
    }
    
    fn block_on<F>(&self, future: F) -> Result<Value, String>
    where
        F: std::future::Future<Output = Result<Value, String>>,
    {
        self.executor.block_on(future)
    }
}
```

#### Step 4: Implement Async Function Execution
```rust
AstNode::AsyncFunction { name, params, body, .. } => {
    // Create async function value
    let func = Value::AsyncFunction {
        name: name.clone(),
        params: params.iter().map(|(_, n)| n.clone()).collect(),
        body: body.clone(),
    };
    
    self.set_variable(name.clone(), func);
    Ok(Value::None)
}

// When calling async function
fn call_async_function(&mut self, func: Value, args: &[Value]) -> Result<Value, String> {
    let future_id = self.next_future_id;
    self.next_future_id += 1;
    
    // Create future
    let future = Value::Future {
        id: future_id,
        state: FutureState::Pending,
        result: None,
    };
    
    // Spawn task in runtime
    if let Some(runtime) = &mut self.async_runtime {
        let task_id = runtime.spawn(async move {
            // Execute function body asynchronously
            // This would need to be properly async
            Ok(Value::None)
        });
    }
    
    Ok(future)
}
```

#### Step 5: Implement Await
```rust
AstNode::AwaitExpression { expr } => {
    let future_val = self.eval_node(expr)?;
    
    if let Value::Future { id, .. } = future_val {
        // Block until future completes
        if let Some(runtime) = &self.async_runtime {
            if let Some(handle) = runtime.tasks.get(&id) {
                // Wait for completion
                let result = runtime.executor.block_on(async {
                    // Get result from handle
                    Ok(Value::None)
                })?;
                
                return Ok(result);
            }
        }
    }
    
    Err("await requires a Future value".to_string())
}
```

### Async Test Example
```j
async fn | fetch_data(str | url) > {
    // Simulate async operation
    await sleep(100)
    return "Data from " + url
}

async fn | main() > {
    // Spawn multiple tasks
    task1 -> spawn fetch_data("https://api1.com")
    task2 -> spawn fetch_data("https://api2.com")
    
    // Await results
    result1 -> await task1
    result2 -> await task2
    
    out(result1)
    out(result2)
}

await main()
```

---

## Implementation Priority & Effort

### 1. Modules (Recommended First)
**Effort**: 4-6 hours  
**Impact**: High - enables code organization  
**Complexity**: Medium - file I/O, caching  

**Why First**: Most straightforward, highest immediate value

### 2. Traits (Recommended Second)
**Effort**: 6-8 hours  
**Impact**: High - enables polymorphism  
**Complexity**: High - type checking, dispatch  

**Why Second**: Builds on modules, enables better OOP

### 3. Async/Await (Recommended Third)
**Effort**: 10-12 hours  
**Impact**: Medium - enables concurrency  
**Complexity**: Very High - runtime, scheduler  

**Why Third**: Most complex, requires external dependencies (Tokio)

---

## Dependencies Needed

### For Async/Await
Add to `Cargo.toml`:
```toml
[dependencies]
tokio = { version = "1.35", features = ["full"] }
futures = "0.3"
async-trait = "0.1"
```

### For Module System
No new dependencies needed (uses std::fs)

### For Trait System
No new dependencies needed

---

## Testing Strategy

### Module Tests
1. Load module from file
2. Export/import specific items
3. Import all from module
4. Module caching works
5. Circular dependency detection

### Trait Tests
1. Define trait with methods
2. Implement trait for class
3. Call trait methods
4. Default implementations work
5. Trait bounds on functions

### Async Tests
1. Async function returns Future
2. Await blocks until completion
3. Multiple tasks run concurrently
4. Error handling in async code
5. Async I/O operations

---

## Next Steps

1. **Start with Modules** - Most impact, least complexity
2. **Add Traits** - Builds on modules
3. **Implement Async** - Most complex, do last

Each feature should be:
- Fully implemented
- Thoroughly tested
- Documented with examples
- Integrated with existing features

---

## Success Criteria

✅ **Modules Complete When:**
- Can load .j files as modules
- Export/import works correctly
- Module caching prevents re-execution
- Circular dependencies detected
- Works with Jolt package manager

✅ **Traits Complete When:**
- Can define traits with methods
- Can implement traits for classes
- Trait method dispatch works
- Default implementations work
- Trait bounds on generics work

✅ **Async Complete When:**
- Async functions return Futures
- Await suspends and resumes
- Multiple tasks run concurrently
- Async I/O operations work
- Error handling works in async context

---

**Total Estimated Effort**: 20-26 hours for complete implementation of all three systems.

**Recommended Approach**: Implement one system at a time, fully test it, then move to the next.
