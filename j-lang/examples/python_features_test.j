# Test Python Killer Features

out("=== Python Killer Features ===\n")

# 1. Parallel Map
out("1. Parallel Map")
list | nums -> [1, 2, 3, 4, 5]
list | squared -> parallel_map(nums, |x| x * x)
out("Squared:", squared)
out("")

# 2. Batched
out("2. Batched")
list | items -> [1, 2, 3, 4, 5, 6, 7, 8, 9]
list | batches -> batched(items, 3)
out("Batches:", batches)
out("")

# 3. Pairwise
out("3. Pairwise")
list | seq -> [1, 2, 3, 4, 5]
list | pairs -> pairwise(seq)
out("Pairs:", pairs)
out("")

# 4. Frequencies
out("4. Frequencies")
list | words -> ["a", "b", "a", "c", "b", "a"]
dict | freq -> frequencies(words)
out("Frequencies:", freq)
out("")

# 5. Dedupe
out("5. Dedupe")
list | with_dupes -> [1, 1, 2, 2, 2, 3, 1, 1]
list | deduped -> dedupe(with_dupes)
out("Deduped:", deduped)
out("")

# 6. Take While
out("6. Take While")
list | numbers -> [1, 2, 3, 4, 5, 6, 7, 8]
list | taken -> take_while(numbers, |x| x < 5)
out("Taken:", taken)
out("")

# 7. Drop While
out("7. Drop While")
list | dropped -> drop_while(numbers, |x| x < 5)
out("Dropped:", dropped)
out("")

# 8. Scan
out("8. Scan")
list | vals -> [1, 2, 3, 4, 5]
list | cumsum -> scan(vals, 0, |acc, x| acc + x)
out("Cumulative sum:", cumsum)
out("")

# 9. Tap (debug helper)
out("9. Tap")
list | tapped -> tap([1, 2, 3], "Debug")
out("")

# 10. Deep Clone
out("10. Deep Clone")
list | original -> [1, 2, 3]
list | cloned -> deep_clone(original)
out("Cloned:", cloned)
out("")

out("All features work!")
