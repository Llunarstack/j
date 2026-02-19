# FIRST HALF TEST
out("Testing first half...")

int | test_count -> 0

# BASIC I/O & UTILITIES
out("\n=== BASIC I/O & UTILITIES ===")
test_count = test_count + 1
out(test_count, ". out: works")

test_count = test_count + 1
out(test_count, ". varType:", varType(42))

test_count = test_count + 1
out(test_count, ". len:", len([1, 2, 3]))

# MATH FUNCTIONS
out("\n=== MATH FUNCTIONS ===")
test_count = test_count + 1
out(test_count, ". abs:", abs(-5))

test_count = test_count + 1
out(test_count, ". sqrt:", sqrt(16))

test_count = test_count + 1
out(test_count, ". pow:", pow(2, 10))

test_count = test_count + 1
out(test_count, ". gcd:", gcd(48, 18))

test_count = test_count + 1
out(test_count, ". lcm:", lcm(12, 18))

test_count = test_count + 1
out(test_count, ". is_prime:", is_prime(17))

test_count = test_count + 1
out(test_count, ". factorial:", factorial(5))

test_count = test_count + 1
out(test_count, ". fibonacci:", fibonacci(10))

out("\nFirst half completed! Tests:", test_count)
