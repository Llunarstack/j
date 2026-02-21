# Comprehensive test of all J language features

# 1. Basic types and operations
int | x -> 42
float | y -> 3.14
str | name -> "J Language"
bool | flag -> true

out("=== Basic Types ===")
out(x)
out(y)
out(name)
out(flag)

# 2. Collections
list | numbers -> [1, 2, 3, 4, 5]
dict | scores -> {"alice": 95, "bob": 87}

out("\n=== Collections ===")
out(numbers)
out(scores)

# 3. Control flow
out("\n=== Control Flow ===")
if x > 40 {
  out("x is greater than 40")
}

int | i -> 0
while i < 3 {
  out("Loop iteration: ")
  out(i)
  i = i + 1
}

# 4. Functions
fn int | add_nums (int | a, int | b) > {
  return a + b
}

out("\n=== Functions ===")
int | sum -> add_nums(10, 20)
out("Sum: ")
out(sum)

# 5. Crypto features
out("\n=== Crypto Features ===")
list | key -> crypto_random_bytes(32)
out("Generated random key (length): ")
out(len(key))

# 6. String operations
out("\n=== String Operations ===")
str | greeting -> "Hello, World!"
out(greeting)
out("Length: ")
out(len(greeting))
out("Uppercase: ")
out(upper(greeting))

# 7. List operations
out("\n=== List Operations ===")
list | nums -> [5, 2, 8, 1, 9]
out("Original: ")
out(nums)
out("Sorted: ")
out(sort(nums))
out("Sum: ")
out(sum(nums))
out("Max: ")
out(max(nums))

# 8. Math operations
out("\n=== Math Operations ===")
out("5 + 3 = ")
out(5 + 3)
out("10 - 4 = ")
out(10 - 4)
out("6 * 7 = ")
out(6 * 7)
out("20 / 4 = ")
out(20 / 4)
out("2 ** 8 = ")
out(2 ** 8)

# 9. Cross-type operations (from fixes)
out("\n=== Cross-Type Operations ===")
out("5 + 2.5 = ")
out(5 + 2.5)
out("5 == 5.0: ")
out(5 == 5.0)

# 10. Short-circuit evaluation (from fixes)
out("\n=== Short-Circuit Evaluation ===")
bool | result1 -> false and (1 / 0 == 0)  # Should not divide by zero
out("false and (1/0 == 0): ")
out(result1)

bool | result2 -> true or (1 / 0 == 0)  # Should not divide by zero
out("true or (1/0 == 0): ")
out(result2)

out("\n=== All Tests Passed! ===")
