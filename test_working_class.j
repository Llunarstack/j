# Working class examples in J

# 1. Simple class with fields
class | Point {
  int | x -> 0
  int | y -> 0
}

# 2. Class with expression methods
class | Calculator {
  int | value -> 0
  fn | get () > value
  fn | double () > value * 2
  fn | add_ten () > value + 10
}

# 3. Class with block methods (single expression)
class | Counter {
  int | count -> 0
  fn | get_count () > { count }
  fn | double_count () > { count * 2 }
}

out("All class definitions successful!")
out("Note: Class instantiation not yet implemented")
out("Note: Methods with multiple statements in blocks not yet working")
