# Test specific sections
out("Testing sections...")

# Test pad functions with 3 args (might be the issue)
out("pad_left:", pad_left("test", 10, " "))
out("pad_right:", pad_right("test", 10, " "))

out("Section test completed!")
