// Test counter arithmetic
out("Testing counter arithmetic")

counter | c1 -> counter("banana")
counter | c2 -> counter("ana")

out("c1:")
out(c1)
out("c2:")
out(c2)

counter | diff -> c1 - c2
out("c1 - c2:")
out(diff)

counter | sum -> c1 + c2
out("c1 + c2:")
out(sum)

out("Complete")
