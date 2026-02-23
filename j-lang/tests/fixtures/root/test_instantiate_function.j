# Test if there's a built-in instantiate function

class | Point {
  int | x -> 5
  int | y -> 10
}

out("Trying to instantiate...")

# Try calling the class directly
p -> Point()
out(p)
