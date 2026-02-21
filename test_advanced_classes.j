# Test Advanced Class Types

out("Testing advanced class types...")

# 1. Regular class (baseline)
class | Point {
  int | x -> 0
  int | y -> 0
  fn | distance () > { (x * x + y * y) }
}

# 2. Data class (auto-equality, hash, copy)
data class | Vector {
  float | x -> 0.0
  float | y -> 0.0
  float | z -> 0.0
}

# 3. Singleton class (single instance)
singleton class | Config {
  str | theme -> "dark"
  int | max_connections -> 100
}

# 4. Actor class (message-based concurrency)
actor class | Counter {
  int | count -> 0
  fn | increment () > { count -> count + 1 }
  fn | get () > count
}

# 5. Threadsafe class (auto-mutex)
threadsafe class | Cache {
  dict | data -> {}
  fn | set (str | key, value) > { data[key] -> value }
  fn | get (str | key) > data[key]
}

# 6. Observable class (reactive)
observable class | Temperature {
  float | value -> 20.0
  fn | set (float | v) > { value -> v }
}

# 7. Secure class (encrypted fields)
secure class | Vault {
  str | password -> ""
  dict | secrets -> {}
}

# 8. Resource class (RAII cleanup)
resource class | FileHandle {
  str | path -> ""
  bool | open -> false
}

out("All advanced class types defined successfully!")
out("Note: Full functionality requires interpreter implementation")
