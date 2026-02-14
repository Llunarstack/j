// Test basic types
int | x -> 42
float | y -> 3.14
str | name -> "J Language"
bool | flag -> true

// Test operations
int | sum -> x + 10
float | product -> y * 2.0

out("Integer: " + str(x))
out("Float: " + str(y))
out("String: " + name)
out("Boolean: " + str(flag))
out("Sum: " + str(sum))
out("Product: " + str(product))
