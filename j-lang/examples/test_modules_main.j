// Test importing a module

out("Testing module system...")

// Import all from module (no specific items)
import test_modules

// Test the imported functions
result1 -> add(5, 3)
out("add(5, 3) = " + str(result1))

result2 -> multiply(4, 7)
out("multiply(4, 7) = " + str(result2))

out("PI = " + str(PI))

out("Module system test complete!")
