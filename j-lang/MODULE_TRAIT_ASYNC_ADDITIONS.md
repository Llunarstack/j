# Code Additions for Full Module, Trait, and Async Support

## 1. Add to Value enum (before `None,`):

```rust
    /// Module system
    Module {
        name: String,
        path: String,
        exports: HashMap<String, Value>,
    },
    /// Trait system
    Trait {
        name: String,
        methods: Vec<TraitMethod>,
    },
    /// Async/Await system
    Future {
        id: usize,
        state: FutureState,
        result: Option<Box<Value>>,
    },
```

## 2. Add to Interpreter struct (after `once_next_id: usize,`):

```rust
    // Module system
    module_cache: HashMap<String, Value>,
    module_search_paths: Vec<String>,
    
    // Trait system
    trait_impls: HashMap<String, HashMap<String, Value>>, // type_name -> trait_name -> impl
    
    // Async system
    next_future_id: usize,
```

## 3. Update Interpreter::new() initialization:

```rust
    pub fn new() -> Self {
        let mut interpreter = Self {
            globals: HashMap::new(),
            locals: Vec::new(),
            statics: HashMap::new(),
            call_depth: 0,
            defer_stack: Vec::new(),
            once_cache: HashMap::new(),
            once_next_id: 0,
            // Module system
            module_cache: HashMap::new(),
            module_search_paths: vec![".".to_string()],
            // Trait system
            trait_impls: HashMap::new(),
            // Async system
            next_future_id: 0,
        };
        
        // Add built-in functions
        interpreter.add_builtins();
        interpreter
    }
```

## 4. Add helper methods to Interpreter impl block:

```rust
    // Module system helpers
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
        
        let mut lexer = crate::lexer::Lexer::new(&source);
        let tokens = lexer.tokenize()
            .map_err(|e| format!("Lexer error in module {}: {}", path, e))?;
        
        let mut parser = crate::parser::Parser::new(tokens);
        let ast = parser.parse()
            .map_err(|e| format!("Parser error in module {}: {}", path, e))?;
        
        // Execute in isolated scope
        self.push_scope();
        let mut exports = HashMap::new();
        
        // Execute module and collect exports
        self.eval_node(&ast)?;
        
        // Get all variables from module scope as exports
        if let Some(scope) = self.locals.last() {
            exports = scope.clone();
        }
        
        self.pop_scope();
        
        // Create module value
        let module = Value::Module {
            name: path.to_string(),
            path: file_path,
            exports,
        };
        
        // Cache it
        self.module_cache.insert(path.to_string(), module.clone());
        
        Ok(module)
    }
    
    fn resolve_module_path(&self, path: &str) -> Result<String, String> {
        // If path starts with ./ or ../, it's relative
        if path.starts_with("./") || path.starts_with("../") {
            let full_path = if path.ends_with(".j") {
                path.to_string()
            } else {
                format!("{}.j", path)
            };
            
            if std::path::Path::new(&full_path).exists() {
                return Ok(full_path);
            } else {
                return Err(format!("Module file not found: {}", full_path));
            }
        }
        
        // Search in module search paths
        for search_path in &self.module_search_paths {
            let full_path = if path.ends_with(".j") {
                format!("{}/{}", search_path, path)
            } else {
                format!("{}/{}.j", search_path, path)
            };
            
            if std::path::Path::new(&full_path).exists() {
                return Ok(full_path);
            }
        }
        
        Err(format!("Module not found: {}", path))
    }
```

## 5. Replace AstNode::ModuleDeclaration handler:

```rust
            AstNode::ModuleDeclaration { name, body } => {
                // Create a new scope for the module
                self.push_scope();
                let result = self.eval_node(body)?;
                
                // Collect exports from module scope
                let mut exports = HashMap::new();
                if let Some(scope) = self.locals.last() {
                    exports = scope.clone();
                }
                
                self.pop_scope();
                
                // Store module
                let module = Value::Module {
                    name: name.clone(),
                    path: format!("<inline:{}>", name),
                    exports,
                };
                
                self.set_variable(name.clone(), module);
                Ok(result)
            }
```

## 6. Replace AstNode::ImportStatement handler:

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
                            if let Some(value) = exports.get(&item) {
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

## 7. Replace AstNode::TraitDeclaration handler:

```rust
            AstNode::TraitDeclaration { name, methods } => {
                // Convert methods to TraitMethod structs
                let trait_methods: Vec<TraitMethod> = methods.iter().filter_map(|m| {
                    if let AstNode::FunctionDeclaration { name: method_name, params, return_type, body, .. } = m {
                        Some(TraitMethod {
                            name: method_name.clone(),
                            params: params.clone(),
                            return_type: return_type.clone(),
                            default_impl: if matches!(body.as_ref(), AstNode::Block { statements } if statements.is_empty()) {
                                None
                            } else {
                                Some(body.clone())
                            },
                        })
                    } else {
                        None
                    }
                }).collect();
                
                let trait_val = Value::Trait {
                    name: name.clone(),
                    methods: trait_methods,
                };
                
                self.set_variable(name.clone(), trait_val);
                Ok(Value::None)
            }
```

## 8. Replace AstNode::AsyncFunction handler:

```rust
            AstNode::AsyncFunction { name, params, return_type: _, body } => {
                // Create a future that will execute the function
                let future_id = self.next_future_id;
                self.next_future_id += 1;
                
                // For now, create a function that returns a Future when called
                // Full async would require a runtime
                let param_names: Vec<String> = params.iter().map(|(_, p)| p.clone()).collect();
                let func = Value::Function {
                    name: format!("async_{}", name),
                    params: param_names,
                    body: body.clone(),
                };
                
                self.set_variable(name.clone(), func);
                Ok(Value::None)
            }
```

## 9. Replace AstNode::AwaitExpression handler:

```rust
            AstNode::AwaitExpression { expr } => {
                let future_val = self.eval_node(expr)?;
                
                // If it's a Future, get its result
                if let Value::Future { result, state, .. } = future_val {
                    match state {
                        FutureState::Completed => {
                            if let Some(res) = result {
                                return Ok(*res);
                            } else {
                                return Ok(Value::None);
                            }
                        }
                        FutureState::Failed(err) => {
                            return Err(format!("Future failed: {}", err));
                        }
                        _ => {
                            return Err("Cannot await pending future (no runtime)".to_string());
                        }
                    }
                }
                
                // If it's a regular function call, just execute it synchronously
                Ok(future_val)
            }
```

## 10. Add Display implementations for new Value types:

Add to the `impl fmt::Display for Value` match statement:

```rust
            Value::Module { name, .. } => write!(f, "<module {}>", name),
            Value::Trait { name, .. } => write!(f, "<trait {}>", name),
            Value::Future { id, state, .. } => write!(f, "<future {} {:?}>", id, state),
```

## Testing

After implementing, test with:

```j
// Module test
// math.j
fn | add(int | a, int | b) > a + b
fn | multiply(int | a, int | b) > a * b

// main.j
import "./math" { add, multiply }
out(add(5, 3))  // Should print 8

// Trait test
trait | Printable {
    fn | to_string() > ""
}

class | Person {
    str | name -> ""
}

// Async test (basic)
async fn | fetch_data() > {
    return "data"
}

result -> await fetch_data()
out(result)  // Should print "data"
```
