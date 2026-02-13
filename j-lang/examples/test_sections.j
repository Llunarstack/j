// Test sections one by one

out("Test 1: Basic types")
int | x -> 10
out(x)

out("Test 2: Type conversion")
int | num -> 42
str*num
out(num)

out("Test 3: Collections")
list | items -> [1, 2, 3]
out(items)

out("Test 4: Slicing")
list | slice -> items[0..2]
out(slice)

out("Test 5: Enums")
enum | Status {
  On = 1
  Off = 2
}
out(Status[1].label)

out("All section tests passed!")
