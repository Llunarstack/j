// Comprehensive test of ALL features from j.txt

out("=== Testing ALL J Language Features ===")

// 1. Basic types
int | num -> 42
float | pi -> 3.14
str | text -> "hello"
bool | flag -> true
char | letter -> 'J'
out("Basic types: OK")

// 2. Special types
emoji | fire -> 🔥
money | price -> $29.99
hex | color -> #FF0066
date | today -> 2026-02-12
time | now -> 14:30:00
datetime | timestamp -> 2026-02-12 14:30:00
out("Special types: OK")

// 3. Infinity
float | pos_inf -> inf
float | neg_inf -> -inf
out("Infinity: OK")

// 4. Collections
list | nums -> [1, 2, 3, 4, 5]
tuple | point -> (10, 20)
dict | config -> { theme: "dark", size: 14 }
set | unique -> {1, 2, 3}
counter | freq -> ["a", "a", "b"]
vec | vector -> [1.0, 2.0, 3.0]
mat | matrix -> [[1, 2], [3, 4]]
grid | g -> [[1, 2], [3, 4]]
out("Collections: OK")

// 5. Type conversion
int | count -> 42
str*count
out("Type conversion: OK")

// 6. Slicing
list | slice1 -> nums[0..3]
list | slice2 -> nums[..by 2]
list | slice3 -> nums[..by -1]
out("Slicing: OK")

// 7. Enums
enum | Status {
  Active = 1
  Inactive = 2
}
out("Enums: OK")

// 8. For loops - all variants
i in nums : out(i)
(i, v) in nums : out(v)
i in 0..5 : out(i)
i in 0..10 by 2 : out(i)
i in nums rev : out(i)
out("For loops: OK")

// 9. Counter operations
counter | c1 -> ["a", "b"]
counter | c2 -> ["a", "c"]
counter | c3 -> c1 + c2
out("Counter arithmetic: OK")

// 10. Grid operations
out(g.rows)
out(g.cols)
out(g.neighbors(0, 0))
out(g.neighbors8(0, 0))
out("Grid operations: OK")

// 11. Classes
class | Point {
  int | x -> 0
  int | y -> 0
  
  fn | init (int | a, int | b) > {
    this.x = a
    this.y = b
  }
}
Point | p -> Point.new(3, 4)
out("Classes: OK")

// 12. Functions
fn | add (int | a, int | b) > a + b
out(add(2, 3))
out("Functions: OK")

// 13. Lambdas
fn | double -> fn x > x * 2
out(double(5))
out("Lambdas: OK")

// 14. Defer
{
  defer out("cleanup")
  out("work")
}
out("Defer: OK")

// 15. Converge
int | val -> 5
converge {
  val = val - 1
  if val <= 0 : break
  val
}
out("Converge: OK")

// 16. Window
list | data -> [1, 2, 3, 4, 5]
window in windowed(data, 2) : out(window)
out("Window: OK")

// 17. Dict access
dict | user -> {
  name: "Alex"
  address: {
    city: "Portland"
  }
}
out(user.name)
out(user.address.city)
out("Dict access: OK")

// 18. Pattern matching
match 42 {
  0 => out("zero")
  42 => out("forty-two")
  _ => out("other")
}
out("Pattern matching: OK")

// 19. Try/catch
try {
  out("trying")
} catch e {
  out("caught")
}
out("Try/catch: OK")

// 20. Pipeline
list | result -> nums |> map(fn x > x * 2) |> filter(fn x > x > 5)
out("Pipeline: OK")

// 21. Broadcast
list | broadcast_result -> add.(nums, 10)
out("Broadcast: OK")

// 22. Generators (yield)
fn | gen (int | max) > {
  i in 0..max : yield i
}
out("Generators: OK")

// 23. Decorators
@memo
fn | fib (int | n) > {
  if n <= 1 : n
  else : fib(n-1) + fib(n-2)
}
out("Decorators: OK")

// 24. Printing features
out("Simple")
out("Colored", {color: "red"})
out("Bold", {style: "bold"})
out("Printing: OK")

// 25. Collection methods
out(nums.map(fn x > x * 2))
out(nums.filter(fn x > x > 2))
out(nums.sum())
out(nums.max())
out("Collection methods: OK")

// 26. String methods
str | upper_text -> text.upper()
out("String methods: OK")

// 27. Type checking
out(varType(num))
out("Type checking: OK")

// 28. File I/O (basic)
write_lines("test_output.txt", ["line1", "line2"])
list | lines -> read_lines("test_output.txt")
out("File I/O: OK")

out("=== ALL FEATURES TESTED ===")
