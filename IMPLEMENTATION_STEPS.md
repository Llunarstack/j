# Implementation Steps for Full Async/Await, Modules, and Traits

## Current Status
- Value enum: Missing Module, Trait, Future variants
- TraitMethod struct: ✅ Already exists
- FutureState enum: ✅ Already exists  
- Interpreter struct: Missing module_cache, trait_impls, async fields

## Step 1: Add Value Variants (DONE - Need to apply)
Add to Value enum before `None`:
- Module { name, path, exports }
- Trait { name, methods }
- Future { id, state, result }

## Step 2: Add Interpreter Fields
Add to Interpreter struct:
```rust
// Module system
module_cache: HashMap<String, Value>,
module_search_paths: Vec<String>,

// Trait system  
trait_impls: HashMap<String, HashMap<String, Value>>, // type_name -> trait_name -> impl

// Async system
next_future_id: usize,
```

## Step 3: Update Interpreter::new()
Initialize new fields in constructor

## Step 4: Implement Module System
- Replace ModuleDeclaration handler with full implementation
- Replace ImportStatement handler with file loading
- Add load_module() helper function
- Add resolve_module_path() helper function

## Step 5: Implement Trait System
- Replace TraitDeclaration handler to store full trait info
- Add TraitImpl AST node handling (if not exists in parser)
- Add trait method dispatch logic
- Add implementation checking

## Step 6: Implement Async/Await
- Replace AsyncFunction handler to return Future
- Replace AwaitExpression handler to block on Future
- Add spawn() builtin for task creation
- Note: Full async runtime with Tokio is complex, start with basic Future tracking

## Priority Order
1. Module System (4-6 hours) - Most straightforward
2. Trait System (6-8 hours) - Builds on modules
3. Async/Await (10-12 hours) - Most complex

## Next Action
Start with Module System implementation
