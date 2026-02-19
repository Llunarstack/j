# ADVANCED ALGORITHM LOOP PATTERNS
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
int | result_l -> -1
int | result_r -> -1

meet (l, r) in arr2 {
    int | current_sum -> arr2[l] + arr2[r]
    
    if current_sum == sum_target {
        result_l = l
        result_r = r
        l = r
    } else {
        if current_sum < sum_target {
            l = l + 1
        } else {
            r = r - 1
        }
    }
}

if result_l >= 0 {
    out("Found:", arr2[result_l], "+", arr2[result_r], "=", sum_target)
}

# 3. SHRINK LOOP
out("\n=== SHRINK LOOP ===")
list | arr3 -> [1, 2, 3, 4, 5]
int | steps -> 0

shrink (left3, right3) in arr3 {
    out("Shrinking: left=", left3, "right=", right3)
    left3 = left3 + 1
    steps = steps + 1
}

out("Shrink completed in", steps, "steps")

# 4. WHILE_NONZERO - Bit counting
out("\n=== WHILE_NONZERO (Bit Count) ===")
int | num -> 42
int | count -> 0

while_nonzero num {
    count = count + (num & 1)
    num = num >> 1
}

out("Number of 1-bits in 42:", count)

# 5. WHILE_CHANGE - Loop until value stabilizes
out("\n=== WHILE_CHANGE (Convergence) ===")
int | iterations -> 0

while_change val = 100 {
    val = val / 2
    iterations = iterations + 1
}

out("Converged after", iterations, "iterations, final value:", val)

# 6. Power of 2 check using bitwise
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
