# Test what class features currently work in J

out("Testing basic class support...")

# Try a simple class
class | Person {
  str | name
  int | age
  
  fn | new (str | n, int | a) > {
    name -> n
    age -> a
  }
  
  fn | greet () > {
    out("Hello, I'm " + name + " and I'm " + age + " years old")
  }
}

# Test instantiation
p -> Person("Alice", 30)
p.greet()

out("Basic class test complete!")
