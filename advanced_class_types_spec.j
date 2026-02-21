# Advanced Class Types Specification for J Language
# These are NOT YET IMPLEMENTED - this is a design spec

# ============================================================
# 1. SECURE CLASS (encrypted fields by default)
# ============================================================
secure class | Vault {
  enc<str>  | master_password_hash
  enc<dict> | secrets
  
  fn new (str | password) > {
    master_password_hash -> password.password_hash()
    secrets -> enc({})
  }
  
  fn store (str | key, str | value) > {
    guard master_password_hash.password_verify(password) : "wrong password"
    secrets[key] = value
  }
  
  fn get (str | key) > secrets[key] or "not found"
}

# Usage:
# vault -> Vault("my_password")
# vault.store("api_key", "secret123")
# out(vault.get("api_key"))

# ============================================================
# 2. SINGLETON CLASS (only one instance ever)
# ============================================================
singleton class | AppConfig {
  dict | settings -> { theme: "dark", log_level: "info" }
  
  fn load () > {
    if "config.json".exists() {
      settings = "config.json".read_json() ?
    }
  }
  
  fn save () > "config.json".write_json(settings)
}

# Usage:
# AppConfig.settings  # always same instance
# AppConfig.load()
# AppConfig.save()

# ============================================================
# 3. ACTOR CLASS (simplified actor model)
# ============================================================
actor class | Counter {
  int | count -> 0
  
  fn inc () > count = count + 1
  fn get () > count
  fn reset () > count = 0
}

# Usage:
# counter -> spawn_actor(Counter)
# parallel {
#   counter.inc()
#   counter.inc()
# }
# out(counter.get())  # exactly 2 - no race

# ============================================================
# 4. OBSERVABLE CLASS (reactive / event-driven)
# ============================================================
observable class | TemperatureSensor {
  float | value -> 22.5
  
  on_change | listeners -> []
  
  fn set (float | new_val) > {
    value = new_val
    listeners.each(_.call(value))
  }
  
  fn subscribe (fn | callback) > listeners -> callback
}

# Usage:
# sensor -> TemperatureSensor()
# sensor.subscribe(fn temp > log.info("Temp changed to " temp))
# sensor.set(25.0)  # triggers all subscribers

# ============================================================
# 5. THREADSAFE CLASS (automatic mutex protection)
# ============================================================
threadsafe class | SharedCache {
  dict | cache -> {}
  
  fn get (str | key) > cache[key]
  fn set (str | key, value) > cache[key] = value
}

# Usage:
# cache -> SharedCache()
# parallel i in 0..1000 {
#   cache.set("key" + i, i * 100)
# }

# ============================================================
# 6. DATA CLASS (value type with auto-equals/hash/copy)
# ============================================================
data class | Point {
  float | x, y, z -> 0, 0, 0
}

# Usage:
# p1 -> Point(1.0, 2.0, 3.0)
# p2 -> p1.copy(x = 99)  # shallow copy with override
# p1 == p2               # false
# p1.hash()              # stable hash
# out(p1)                # "Point(x:1.0 y:2.0 z:3.0)"

# ============================================================
# 7. RESOURCE CLASS (RAII-style auto-cleanup)
# ============================================================
resource class | DatabaseConn {
  priv str | url
  priv bool | open -> false
  
  fn new (str | url) > {
    this.url = url
    open = true
    log.info("DB connected")
  }
  
  fn close () > {
    open = false
    log.info("DB disconnected")
  }
}

# Usage:
# with DatabaseConn("postgres://...") as db {
#   db.query("SELECT * FROM users")
# }  # auto .close() at end - even on panic

# ============================================================
# IMPLEMENTATION NOTES
# ============================================================
# To implement these, we need to:
# 
# 1. Add new TokenTypes: Secure, Singleton, Actor, Observable, 
#    Threadsafe, Data, Resource
# 
# 2. Extend ClassDeclaration AST node with class_type field
# 
# 3. Add special handling in interpreter for each type:
#    - secure: wrap all fields in encryption
#    - singleton: maintain global instance registry
#    - actor: wrap in message queue + mutex
#    - observable: inject change listeners
#    - threadsafe: wrap all methods in mutex
#    - data: auto-generate ==, hash, copy, to_str
#    - resource: inject destructor/cleanup logic
# 
# 4. Add runtime support for:
#    - Actor message queues
#    - Observable event system
#    - Resource cleanup on scope exit
#    - Singleton instance registry
