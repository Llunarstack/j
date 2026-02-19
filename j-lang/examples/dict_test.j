# Test dict operations
out("Testing dict operations...")

# Create a dict
dict | test_dict -> {a: 1, b: 2, c: 3}
out("Dict:", test_dict)

# Test keys
out("Keys:", keys(test_dict))

# Test values
out("Values:", values(test_dict))

out("Dict test completed!")
