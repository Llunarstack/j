# String utilities module

fn str | greet (str | name) > {
  str | prefix -> "Hello, "
  str | suffix -> "!"
  str | result -> prefix
  return result
}

fn str | repeat_str (str | text, int | times) > {
  str | result -> ""
  int | i -> 0
  while i < times {
    result = result text
    i = i + 1
  }
  return result
}
