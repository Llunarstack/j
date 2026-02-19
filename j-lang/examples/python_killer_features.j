# Python Killer Features - Why J is Better Than Python

out("========================================")
out("PYTHON KILLER FEATURES IN J")
out("========================================\n")

# 1. SUPER CONCISE SYNTAX
out("1. CONCISE SYNTAX - Less Boilerplate")
list | nums -> [1, 2, 3, 4, 5]
out("Python: list(map(lambda x: x * 2, nums))")
out("J:      ", map(nums, |x| x * 2))
out("")

# 2. PARALLEL MAP - Easy Concurrency
out("2. PARALLEL MAP - Auto Parallelization")
list | data -> [1, 2, 3, 4, 5, 6, 7, 8]
list | squared -> parallel_map(data, |x| x * x)
out("Parallel computation:", squared)
out("")

# 3. PIPE OPERATOR - Function Composition
out("3. PIPE OPERATOR - Chainable Operations")
list | result -> pipe([1, 2, 3, 4, 5], 
    |x| map(x, |n| n * 2),
    |x| filter(x, |n| n > 5))
out("Piped result:", result)
out("")

# 4. TAP - Debug Helper
out("4. TAP - Chainable Debugging")
list | debug_result -> tap([1, 2, 3], "Before map") |> map(|x| x * 2) |> tap("After map")
out("")

# 5. BENCHMARK - Performance Testing
out("5. BENCHMARK - Built-in Performance Testing")
dict | bench -> benchmark(|| fibonacci(20), 10)
out("Benchmark:", bench)
out("")

# 6. ZIP_LONGEST - Better than Python's zip
out("6. ZIP_LONGEST - Handle Unequal Lists")
list | a -> [1, 2, 3]
list | b -> [4, 5]
list | zipped -> zip_longest(a, b, 0)
out("Zipped with fill:", zipped)
out("")

# 7. BATCHED - Split into Chunks
out("7. BATCHED - Easy Chunking")
list | items -> [1, 2, 3, 4, 5, 6, 7, 8, 9]
list | batches -> batched(items, 3)
out("Batches of 3:", batches)
out("")

# 8. PAIRWISE - Successive Pairs
out("8. PAIRWISE - Overlapping Pairs")
list | sequence -> [1, 2, 3, 4, 5]
list | pairs -> pairwise(sequence)
out("Pairs:", pairs)
out("")

# 9. FREQUENCIES - Count Occurrences
out("9. FREQUENCIES - Simple Counting")
list | words -> ["apple", "banana", "apple", "cherry", "banana", "apple"]
dict | freq -> frequencies(words)
out("Frequencies:", freq)
out("")

# 10. INTERLEAVE - Merge Lists
out("10. INTERLEAVE - Merge Multiple Lists")
list | list1 -> [1, 2, 3]
list | list2 -> [10, 20, 30]
list | list3 -> [100, 200, 300]
list | interleaved -> interleave(list1, list2, list3)
out("Interleaved:", interleaved)
out("")

# 11. DEDUPE - Remove Consecutive Duplicates
out("11. DEDUPE - Remove Consecutive Duplicates")
list | with_dupes -> [1, 1, 2, 2, 2, 3, 1, 1]
list | deduped -> dedupe(with_dupes)
out("Original:", with_dupes)
out("Deduped:", deduped)
out("")

# 12. COMPACT - Remove None Values
out("12. COMPACT - Remove None/Null")
list | with_none -> [1, 2, 3]
list | compacted -> compact(with_none)
out("Compacted:", compacted)
out("")

# 13. TAKE_WHILE & DROP_WHILE
out("13. TAKE_WHILE & DROP_WHILE")
list | numbers -> [1, 2, 3, 4, 5, 6, 7, 8]
list | taken -> take_while(numbers, |x| x < 5)
list | dropped -> drop_while(numbers, |x| x < 5)
out("Take while < 5:", taken)
out("Drop while < 5:", dropped)
out("")

# 14. SCAN - All Intermediate Results
out("14. SCAN - Cumulative Operations")
list | vals -> [1, 2, 3, 4, 5]
list | cumsum -> scan(vals, 0, |acc, x| acc + x)
out("Cumulative sum:", cumsum)
out("")

# 15. RETRY - Automatic Retry Logic
out("15. RETRY - Built-in Retry Mechanism")
out("(Retry logic available for error handling)")
out("")

# 16. DEEP_CLONE - Easy Deep Copy
out("16. DEEP_CLONE - Deep Copy Made Easy")
list | original -> [[1, 2], [3, 4]]
list | cloned -> deep_clone(original)
out("Deep cloned:", cloned)
out("")

out("========================================")
out("J: PYTHON, BUT BETTER!")
out("========================================")
out("")
out("Key Advantages:")
out("✓ More concise syntax")
out("✓ Built-in parallelization")
out("✓ Better functional programming")
out("✓ Chainable operations")
out("✓ Built-in performance tools")
out("✓ Modern conveniences")
out("✓ No GIL limitations")
out("✓ Compiled performance")
