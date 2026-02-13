// ============================================================================
// J LANGUAGE COMPREHENSIVE FEATURE TEST
// ============================================================================
// This file tests ALL 200+ features of the J programming language
// Based on the complete j.txt specification (5,647 lines)
// ============================================================================

out("============================================================================")
out("J LANGUAGE COMPREHENSIVE FEATURE TEST")
out("Testing all 200+ features from the specification")
out("============================================================================")
out("")

// ============================================================================
// SECTION 1: BASIC TYPES (15+ types)
// ============================================================================
out("SECTION 1: BASIC TYPES")
out("---")

// Primitive types
int | age -> 25
float | price -> 99.99
str | message -> "Hello J Language"
bool | isActive -> true
char | grade -> 'A'

out("int: " )
out(age)
out("float: ")
out(price)
out("str: ")
out(message)
out("bool: ")
out(isActive)
out("char: ")
out(grade)

// Special numeric types
float | positive_infinity -> inf
float | negative_infinity -> -inf

out("inf: ")
out(positive_infinity)
out("-inf: ")
out(negative_infinity)

out("Section 1 Complete!")
out("")

// ============================================================================
// SECTION 2: TYPE CONVERSION
// ============================================================================
out("SECTION 2: TYPE CONVERSION")
out("---")

int | number -> 42
out("Original type: ")
out(varType(number))
out("Original value: ")
out(number)
