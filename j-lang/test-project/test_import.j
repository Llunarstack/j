# Test importing a function
j; -> "test-project/src/math_utils.j"

# Try to call the function
out("Calling add_nums...")
int | result -> add_nums(5, 3)
out(result)
