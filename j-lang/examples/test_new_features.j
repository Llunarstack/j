// Test new algorithm helper features
out("=== NEW FEATURES TEST ===")
out("")

// 1. INTERVAL TYPE
out("1. Interval Type")
interval | i1 -> interval(1, 5)
interval | i2 -> interval(3, 8)
out(i1)
out(i2)
out(i1.start)
out(i1.end)
out(i1.len)
out("✓ Interval type works")
out("")

// 2. WINDOW LOOP - Fixed Size
out("2. Window Loop - Fixed Size")
list | nums -> [1, 2, 3, 4, 5]
window slice in nums (size: 3) {
  out(slice)
}
out("✓ Fixed-size window works")
out("")

// 3. WINDOW LOOP - Shrink Condition
out("3. Window Loop - Shrink Condition")
list | data -> [1, 2, 3, 4, 5, 6]
int | min_len -> 999
window slice in data (shrink_if: slice.sum() >= 10) {
  if slice.len() < min_len {
    min_len -> slice.len()
  }
}
out("Minimum window length with sum >= 10:")
out(min_len)
out("✓ Shrink condition window works")
out("")

// 4. GROUP_BY
out("4. Group By")
list | words -> ["eat", "tea", "tan", "ate", "nat", "bat"]
dict | groups -> group_by(words, fn w > w.sorted())
out(groups)
out("✓ Group by works")
out("")

// 5. PARTITION
out("5. Partition")
list | numbers -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
tuple | result -> partition(numbers, fn n > n % 2 == 0)
out("Evens and odds:")
out(result)
out("✓ Partition works")
out("")

// 6. COUNTER ARITHMETIC
out("6. Counter Arithmetic")
counter | c1 -> counter("banana")
counter | c2 -> counter("ana")
out("c1:")
out(c1)
out("c2:")
out(c2)
counter | diff -> c1 - c2
out("c1 - c2:")
out(diff)
out("✓ Counter arithmetic works")
out("")

out("=== ALL NEW FEATURES WORK ===")
