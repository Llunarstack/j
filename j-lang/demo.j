// J-Lang Feature Demonstration

out("=== J-LANG DEMONSTRATION ===\n")

// 1. Variables and types
int | age -> 25
str | name -> "Alice"
float | score -> 95.5
bool | active -> true
out("✓ Variables and basic types")

// 2. Lists and operations
list | nums -> [5, 2, 8, 1, 9]
int | total -> len(nums)
list | sorted_nums -> sort(nums)
out("✓ Lists and operations")

// 3. Dictionaries
dict | person -> {"name": "Bob", "age": 30}
str | person_name -> person["name"]
out("✓ Dictionaries")

// 4. Functions
fn | calculate(int|a, int|b) > {
    return a + b * 2
}
int | result -> calculate(5, 3)
out("✓ User-defined functions")

// 5. Control flow
if age > 18 {
    out("✓ If statements")
}

int | i -> 0
while i < 3 {
    i = i + 1
}
out("✓ While loops")

for n in 1..5 {
    // Loop
}
out("✓ For loops")

// 6. Enhanced for loops
for (index, value) in nums {
    // Indexed iteration
}
out("✓ Indexed for loops")

for n in nums rev {
    // Reverse
}
out("✓ Reverse iteration")

for n in nums if n > 5 {
    // Filtered
}
out("✓ Filtered iteration")

// 7. Match expressions
match age {
    25: out("✓ Match expressions")
    _: out("Other")
}

// 8. Enums
enum | Status {
    Active = 1,
    Inactive = 0
}
out("✓ Enums")

// 9. Vectors
vec | v1 -> [1.0, 2.0, 3.0]
vec | v2 -> [4.0, 5.0, 6.0]
float | dot_result -> dot(v1, v2)
out("✓ Vectors and dot product")

// 10. String operations
str | message -> "Hello World"
list | parts -> split(message, " ")
str | combined -> join(parts, "-")
out("✓ String operations")

// 11. Math operations
int | abs_val -> abs(-10)
float | sqrt_val -> sqrt(25.0)
int | min_val -> min(3, 7)
int | max_val -> max(3, 7)
out("✓ Math operations")

// 12. File I/O
write("output.txt", "Hello from J-Lang!")
str | file_data -> read("output.txt")
out("✓ File I/O")

// 13. Type conversions
int | as_int -> int(3.7)
float | as_float -> float(42)
str | as_str -> str(100)
out("✓ Type conversions")

// 14. Slicing
list | part -> nums[1..4]
out("✓ Slicing")

// 15. Static variables
static int | counter -> 0
counter = counter + 1
out("✓ Static variables")

out("\n=== DEMONSTRATION COMPLETE ===")
out("✅ J-Lang: A modern, feature-rich language!")
