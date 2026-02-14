// Core features test
out("Testing Core Features")

// Types
int | x -> 10
float | y -> 3.14
str | s -> "hello"
bool | b -> true
char | c -> 'A'
out("✓ Types")

// Collections
list | nums -> [1, 2, 3]
tuple | t -> (1, 2)
out("✓ Collections")

// Operators
int | sum -> 5 + 3
bool | cmp -> 10 > 5
out("✓ Operators")

// Control flow
if x > 5 : out("✓ If works")

// Loops
i in 1..3 : out(i)
out("✓ Loops")

// Functions
fn | double (int | n) > n * 2
int | result -> double(5)
out(result)
out("✓ Functions")

// Slicing
list | slice -> nums[0..2]
out("✓ Slicing")

// Enums
enum | Status { On = 1, Off = 2 }
out(Status[1].label)
out("✓ Enums")

// Type conversion
int | num -> 42
str*num
out("✓ Type conversion")

out("")
out("=== ALL CORE FEATURES WORK ===")
