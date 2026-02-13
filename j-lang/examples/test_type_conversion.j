# Test type conversion operator (str*count syntax)

# Original variable
int | count -> 42

# Convert to string (creates new variable with same name, shadowing the old one)
str*count

# Now count is a string
out("count is now: " + count)
out("Type: " + varType(count))

# Test with other types
float | pi -> 3.14
str*pi
out("pi as string: " + pi)

int | value -> 100
float*value
out(value)

out("Type conversion test complete!")
