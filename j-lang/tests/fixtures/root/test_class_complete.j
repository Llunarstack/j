# Complete class test

class | Counter {
  int | count -> 0
  
  fn | increment () > {
    count -> count + 1
  }
  
  fn | get_value () > count
  
  fn | reset () > {
    count -> 0
  }
}

out("Class defined successfully!")

# TODO: Test instantiation when implemented
# c -> Counter()
# c.increment()
# out(c.get_value())
