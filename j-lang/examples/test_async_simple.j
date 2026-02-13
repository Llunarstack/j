// Simple async test

out("Testing async function")

async fn | fetchData () > {
  out("Inside async function")
  str | result -> "done"
  result
}

str | x -> fetchData()
out(x)
