# Test retry with lambda
out("Testing retry...")

# Try retry with a simple lambda
int | result -> retry(|| 42, 3)
out("Result:", result)

out("Retry test completed!")
