# Test class with methods

class | Counter {
  int | value -> 0
  fn | inc () > { value -> value + 1 }
  fn | get () > value
}

out("Class with methods defined")
