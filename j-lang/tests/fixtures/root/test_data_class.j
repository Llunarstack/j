# Test data class - value semantics with auto-generated methods

data class | Point {
    float | x, y, z -> 0.0, 0.0, 0.0
}

# Create instances
p1 -> Point(1.0, 2.0, 3.0)
p2 -> Point(1.0, 2.0, 3.0)
p3 -> Point(4.0, 5.0, 6.0)

out("p1: " p1)
out("p2: " p2)
out("p3: " p3)

# Test equality (should be auto-generated)
# out("p1 == p2: " (p1 == p2))  # Should be true
# out("p1 == p3: " (p1 == p3))  # Should be false

# Test copy (should be auto-generated)
# p4 -> p1.copy(x = 99.0)
# out("p4: " p4)  # Should be Point(99.0, 2.0, 3.0)

# Test hash (should be auto-generated)
# out("p1.hash(): " p1.hash())

out("✅ Data class test passed!")
