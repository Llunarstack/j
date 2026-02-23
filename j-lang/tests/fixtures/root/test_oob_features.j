# Test OOB (Out-of-Band) Features

# 1. flow - Reactive data dependency graph
out("=== Testing flow (Reactive Dependencies) ===")
flow {
    a -> 10
    b -> 20
    c := a + b
    d := c * 2
    e := d + a
}

out("c = " c)  # Should be 30
out("d = " d)  # Should be 60
out("e = " e)  # Should be 70

# Update a and see reactive updates
a = 15
out("After a=15:")
out("c = " c)  # Should update to 35
out("d = " d)  # Should update to 70
out("e = " e)  # Should update to 85

# 2. probe - Runtime value inspection hooks
out("\n=== Testing probe (Value Inspection) ===")
int | x -> 0
probe x { value -> out("x changed to " value) }

x = 42   # Should print "x changed to 42"
x = 100  # Should print "x changed to 100"

# 3. fuse - Compile-time code fusion
out("\n=== Testing fuse (Code Fusion) ===")
fuse fn | square (int | n) > n * n

out("square(5) = " square(5))  # Should be 25

# Fuse pipeline
fuse pipeline {
    [1, 2, 3, 4, 5] |> filter(_ % 2 == 0) |> map(_ * 10)
}

# 4. veil - Oblivious data access (constant-time)
out("\n=== Testing veil (Constant-Time Access) ===")
veil dict | secure_cache -> { "key1": "secret1", "key2": "secret2" }

str | value1 -> secure_cache.veil_get("key1")
out("Secure value: " value1)  # Should be "secret1"

# Veil block for constant-time operations
veil {
    str | password -> "admin123"
    str | input -> "admin123"
    bool | match -> password ~== input  # Constant-time comparison
    out("Password match: " match)
}

# 5. warp - Compile-time metaprogramming
out("\n=== Testing warp (Metaprogramming) ===")
warp template | make_logger (str | prefix) > {
    fn | log (str | msg) > out("[{prefix}] " msg)
}

make_logger("INFO") | info_log
info_log("System started")  # Should print "[INFO] System started"

make_logger("ERROR") | error_log
error_log("Something failed")  # Should print "[ERROR] Something failed"

# 6. ghost - Optional ghost variables (debug-only)
out("\n=== Testing ghost (Debug Variables) ===")
ghost int | debug_counter -> 0

# This counter only exists in debug builds
ghost debug_counter = debug_counter + 1
ghost debug_counter = debug_counter + 1
ghost debug_counter = debug_counter + 1

# In debug: prints counter, in release: stripped
out("Debug counter: " debug_counter)

out("\n=== All OOB Features Tested ===")
