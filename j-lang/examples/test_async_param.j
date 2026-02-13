// Test async with parameter

out("Testing async with parameter")

async fn | greet (str | name) > {
  out("Hello " name)
  name
}

str | result -> greet("World")
out("Result: " result)
