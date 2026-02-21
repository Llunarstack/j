# Test class property access

class | Config {
  int | max_connections -> 100
}

out("Class defined")
out(Config)
out("Accessing property...")
val -> Config.max_connections
out(val)
