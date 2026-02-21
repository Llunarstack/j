# Test module imports

# Execute math_utils module
j; -> "test-project/src/math_utils.j"

# Execute string_utils module  
j; -> "test-project/src/string_utils.j"

# Now use the functions from those modules
out("=== Testing Math Utils ===")
int | sum -> add_nums(10, 20)
out("10 + 20 = ")
out(sum)

int | product -> mult(5, 6)
out("5 * 6 = ")
out(product)

int | sq -> square(7)
out("7^2 = ")
out(sq)

int | fact -> factorial(5)
out("5 factorial = ")
out(fact)

out("\n=== Testing String Utils ===")
str | greeting -> greet("World")
out(greeting)

str | repeated -> repeat_str("Hi! ", 3)
out(repeated)

out("\n=== All Module Tests Passed! ===")
