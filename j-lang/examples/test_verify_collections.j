// Collections test
out("Testing Collections")

// Lists
list | nums -> [1, 2, 3, 4, 5]
out(nums)

// Tuples
tuple | t -> (10, 20)
out(t)

// Dictionaries - use identifier keys with colon
dict | d -> {name: "John", age: 30}
out(d)

// Sets
set | s -> {1, 2, 3}
out(s)

out("All collections work!")
