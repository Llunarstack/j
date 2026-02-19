# Simple test to verify basic functions work
out("Testing basic functions...")

# Test 1: Basic output
out("1. out: works")

# Test 2: varType
out("2. varType:", varType(42))

# Test 3: len
out("3. len:", len([1, 2, 3]))

# Test 4: Math functions
out("4. abs:", abs(-5))
out("5. sqrt:", sqrt(16))
out("6. pow:", pow(2, 10))

# Test 5: List operations
list | nums -> [1, 2, 3, 4, 5]
out("7. sum:", sum(nums))
out("8. min:", min(nums))
out("9. max:", max(nums))
out("10. reverse:", reverse(nums))
out("11. sort:", sort([5, 2, 8, 1, 9]))

# Test 6: String operations
out("12. upper:", upper("hello"))
out("13. lower:", lower("HELLO"))
out("14. trim:", trim("  hello  "))

out("\nBasic tests completed!")
