# Test new() function for class instantiation

class | Point {
  int | x -> 0
  int | y -> 0
}

out("Creating instance with new()...")
instance | p -> new(Point)
out(p)

out("")
out("Creating instance with custom values...")
instance | p2 -> new(Point, "x", 10, "y", 20)
out(p2)
