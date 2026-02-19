# Test first three loops

# 1. SWEEP LOOP
out("=== SWEEP LOOP ===")
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

out("Max window length:", max_len)

# 2. MEET LOOP
out("\n=== MEET LOOP ===")
list | arr2 -> [1, 2, 3, 4, 5, 6, 7, 8, 9]
int | sum_target -> 10
bool | found -> false
int | current_sum -> 0

meet (l, r) in arr2 {
    current_sum = arr2[l] + arr2[r]
    
    if current_sum == sum_target {
        out("Found:", arr2[l], "+", arr2[r])
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

out("Done!")
