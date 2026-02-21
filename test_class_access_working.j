# Test what actually works with classes

class | Config {
  int | max_connections -> 100
  str | theme -> "dark"
}

out("Class defined:")
out(Config)

out("")
out("Testing class instantiation with Constructor...")

# The interpreter has Value::Constructor support
# Let's see if we can access it
