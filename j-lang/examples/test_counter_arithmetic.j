# Test Counter arithmetic operations

# Create two counters
counter | c1 -> ["a", "a", "b", "c"]
counter | c2 -> ["b", "b", "c", "d"]

out("Counter 1:")
out(c1.most_common)

out("Counter 2:")
out(c2.most_common)

# Add counters (combine counts)
counter | c3 -> c1 + c2
out("c1 + c2:")
out(c3.most_common)

# Subtract counters
counter | c4 -> c1 - c2
out("c1 - c2:")
out(c4.most_common)

out("Counter arithmetic test complete!")
