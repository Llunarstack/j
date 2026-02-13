// Test potentially missing features

out("Testing missing features")

// Test set literal
set | s -> {1, 2, 3}
out(s)

// Test money
money | price -> $29.99
out(price)

// Test hex
hex | color -> #FF0066
out(color)

// Test date/time
date | d -> 2026-02-12
out(d)

time | t -> 14:30:00
out(t)

datetime | dt -> 2026-02-12 14:30:00
out(dt)

out("All tests complete")
