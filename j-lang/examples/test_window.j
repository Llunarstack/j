// Test window loop
out("Testing window loop")

list | nums -> [1, 2, 3, 4, 5]

out("Fixed size window:")
window slice in nums (size: 3) {
  out(slice)
}

out("Complete")
