# ADVANCED ALGORITHM LOOP PATTERNS - NEW SYNTAX
out("========================================")
out("ADVANCED ALGORITHM LOOP PATTERNS")
out("========================================\n")

# 1. SWEEP LOOP - Two-pointer sliding window
out("=== SWEEP LOOP (Two-Pointer) ===")
list | nums -> [1, 2, 3, 4, 5]
int | target -> 9
int | max_len -> 0
int | window_sum -> 0

sweep (left, right) in nums {
    window_sum = sum(nums[left .. right + 1])
    
    if window_sum <= target {
        if right - left + 1 > max_len {
            max_len = right - left + 1
        }
        right = right + 1
    } else {
        left = left + 1
    }
}

out("Max window length with sum <=", target, ":", max_len)

# 2. MEET LOOP - Two pointers moving toward each other
out("\n=== MEET LOOP (Two-Sum) ===")
list | arr2 -> [1, 2, 3, 4, 5, 6, 7, 8, 9]
int | sum_target -> 10
bool | found -> false
int | current_sum -> 0

meet (l, r) in arr2 {
    current_sum = arr2[l] + arr2[r]
    
    if current_sum == sum_target {
        out("Found:", arr2[l], "+", arr2[r], "=", sum_target)
        found = true
        break
    } else {
        if current_sum < sum_target {
            l = l + 1
        } else {
            r = r - 1
        }
    }
}

if not found {
    out("No pair found")
}

# 3. BINARY SEARCH LOOP
out("\n=== BINARY SEARCH LOOP ===")
list | arr -> [1, 3, 5, 7, 9, 11, 13, 15]
int | search -> 11
int | found_at -> -1
int | mid -> 0

binary (lo, hi) in arr {
    mid = (lo + hi) / 2
    
    if arr[mid] == search {
        found_at = mid
        break
    } else {
        if arr[mid] < search {
            lo = mid + 1
        } else {
            hi = mid - 1
        }
    }
} else {
    out("Not found")
}

out("Found", search, "at index:", found_at)

# 4. DP LOOP - Dynamic programming table
out("\n=== DP LOOP (Fibonacci) ===")
int | n -> 10

dp fib[n] = 0 {
    fib[0] = 0
    fib[1] = 1
    
    i in 2 .. n {
        fib[i] = fib[i-1] + fib[i-2]
    }
}

out("Fibonacci sequence:", fib)

# 5. WHILE_NONZERO - Bit counting
out("\n=== WHILE_NONZERO (Bit Count) ===")
int | num -> 42
int | count -> 0

while_nonzero num {
    count = count + (num & 1)
    num = num >> 1
}

out("Number of 1-bits in 42:", count)

# 6. WHILE_CHANGE - Loop until value stabilizes
out("\n=== WHILE_CHANGE (Convergence) ===")
int | iterations -> 0

while_change val = 100 {
    val = val / 2
    iterations = iterations + 1
}

out("Converged after", iterations, "iterations, final value:", val)

# 7. Power of 2 check using bitwise
out("\n=== POWER OF 2 CHECK ===")
int | test_num -> 16
bool | is_pow2 -> test_num > 0 and (test_num & (test_num - 1)) == 0
out("Is 16 a power of 2?", is_pow2)

test_num = 18
is_pow2 = test_num > 0 and (test_num & (test_num - 1)) == 0
out("Is 18 a power of 2?", is_pow2)

out("\n========================================")
out("ALL ADVANCED LOOPS WORK!")
out("========================================")
