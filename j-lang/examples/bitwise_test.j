# BITWISE OPERATIONS TEST
out("========================================")
out("BITWISE OPERATIONS IN J")
out("========================================\n")

# Using hex literals (binary not yet implemented)
int | a -> 10  # 0b1010
int | b -> 12  # 0b1100

out("a = 10 (0b1010)")
out("b = 12 (0b1100)\n")

# Basic bitwise operations
out("=== BASIC BITWISE OPERATIONS ===")
out("a & b  (AND):", a & b, "  # 8 (0b1000)")
out("a | b  (OR):", a | b, "   # 14 (0b1110)")
out("a ^ b  (XOR):", a ^ b, "  # 6 (0b0110)")

# Bitwise NOT
int | c -> 5
out("~c (NOT of 5):", ~c)

# Shift operations
out("\n=== SHIFT OPERATIONS ===")
out("a << 2 (left shift):", a << 2, "  # 40 (0b101000)")
out("a >> 1 (right shift):", a >> 1, "  # 5 (0b0101)")

# Practical examples
out("\n=== PRACTICAL EXAMPLES ===")

# Check if power of 2
int | n -> 16
bool | is_pow2 -> n > 0 and (n & (n - 1)) == 0
out("Is", n, "a power of 2?", is_pow2)

# Extract lower 4 bits (nibble)
int | val -> 214  # 0xD6 = 0b11010110
int | nibble -> val & 15  # 0xF = 15
out("Lower nibble of 214:", nibble, " # 6 (0b0110)")

# Set specific bits
int | flags -> 0
flags = flags | 4  # Set bit 2 (0b0100)
out("Flags after setting bit 2:", flags)

out("\n========================================")
out("BITWISE OPERATIONS WORK!")
out("========================================")
