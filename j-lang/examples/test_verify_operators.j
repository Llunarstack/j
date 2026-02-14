// Operators test
out("Testing Operators")

// Arithmetic
int | a -> 10
int | b -> 5
int | sum -> a + b
int | diff -> a - b
int | prod -> a * b
int | quot -> a / b
out(sum)
out(diff)
out(prod)
out(quot)

// Comparison
bool | gt -> a > b
bool | eq -> a == a
out(gt)
out(eq)

// Logical
bool | and_result -> true and false
bool | or_result -> true or false
out(and_result)
out(or_result)

out("All operators work!")
