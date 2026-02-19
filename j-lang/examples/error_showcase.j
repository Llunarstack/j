# ERROR SHOWCASE - Demonstrating improved error messages
# Uncomment one error at a time to see the enhanced error messages

# ========================================
# 1. UNDEFINED VARIABLE ERROR
# ========================================
# out(undefined_variable)

# ========================================
# 2. UNDEFINED FUNCTION ERROR
# ========================================
# result = unknown_func(42)

# ========================================
# 3. DIVISION BY ZERO
# ========================================
# int | x -> 10
# int | y -> 0
# int | result -> x / y

# ========================================
# 4. INDEX OUT OF BOUNDS
# ========================================
# list | nums -> [1, 2, 3]
# int | val -> nums[10]

# ========================================
# 5. TYPE MISMATCH
# ========================================
# int | x -> 5
# str | y -> "hello"
# int | result -> x + y

# ========================================
# 6. WRONG ARGUMENT COUNT
# ========================================
# fn | greet(str|name) > {
#     out("Hello", name)
# }
# greet("Alice", "Bob")

# ========================================
# 7. SYNTAX ERROR - Missing arrow
# ========================================
# int | x 5

# ========================================
# 8. SYNTAX ERROR - Missing pipe
# ========================================
# int x -> 5

out("All errors commented out - uncomment one at a time to test!")
