// Basic verification
out("=== BASIC FEATURES ===")

// Types
int | x -> 42
float | y -> 3.14
str | s -> "hello"
bool | b -> true
char | c -> 'A'
out(x)
out(y)
out(s)
out(b)
out(c)

// Operators
int | sum -> 10 + 5
int | diff -> 10 - 5
int | prod -> 10 * 5
out(sum)
out(diff)
out(prod)

// Comparison
bool | gt -> 10 > 5
bool | eq -> 5 == 5
out(gt)
out(eq)

// Logical
bool | and_result -> true and false
bool | or_result -> true or false
out(and_result)
out(or_result)

// Collections
list | nums -> [1, 2, 3]
tuple | point -> (10, 20)
set | unique -> [1, 2, 3]
grid | matrix -> [[1, 2], [3, 4]]
out(nums)
out(point)
out(unique)
out(matrix)

out("=== ALL BASIC FEATURES WORK ===")
