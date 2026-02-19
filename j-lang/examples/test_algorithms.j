# Test algorithms one by one

out("=== Test 1: Two Sum ===")
list | arr -> [1, 2, 3, 4, 5, 6, 7, 8, 9]
int | target -> 10
int | found_l -> -1
int | found_r -> -1

meet (l, r) in arr {
    int | s -> arr[l] + arr[r]
    
    if s == target {
        found_l = l
        found_r = r
        l = r
    } else {
        if s < target {
            l = l + 1
        } else {
            r = r - 1
        }
    }
}

if found_l >= 0 {
    out("Found:", arr[found_l], "+", arr[found_r], "=", target)
}

out("\n=== Test 2: Bit Count ===")
int | n -> 42
int | bits -> 0

while_nonzero n {
    bits = bits + (n & 1)
    n = n >> 1
}

out("Bit count:", bits)

out("\n=== Test 3: Power of 2 ===")
list | nums -> [1, 2, 3, 4, 8, 15, 16]
i in nums {
    bool | pow2 -> i > 0 and (i & (i - 1)) == 0
    out(i, "->", pow2)
}

out("\nAll tests complete!")
