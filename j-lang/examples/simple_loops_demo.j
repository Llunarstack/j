# ADVANCED LOOP PATTERNS DEMO
out("========================================")
out("ADVANCED ALGORITHM LOOP PATTERNS")
out("========================================\n")

# 1. Two-Pointer Pattern (SWEEP)
out("=== TWO-POINTER PATTERN ===")
list | nums -> [1, 2, 3, 4, 5]
int | target -> 9
int | left -> 0
int | right -> 0
int | max_len -> 0
int | window_sum -> 0

while right < len(nums) {
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

# 2. Two-Sum with Meet Pattern
out("\n=== TWO-SUM PATTERN ===")
list | sorted -> [1, 2, 3, 4, 5, 6, 7, 8, 9]
int | sum_target -> 10
int | l -> 0
int | r -> len(sorted) - 1
int | current_sum -> 0

while l < r {
    current_sum = sorted[l] + sorted[r]
    
    if current_sum == sum_target {
        out("Found:", sorted[l], "+", sorted[r], "=", sum_target)
        break
    } else if current_sum < sum_target {
        l = l + 1
    } else {
        r = r - 1
    }
}

# 3. Binary Search Pattern
out("\n=== BINARY SEARCH PATTERN ===")
list | arr -> [1, 3, 5, 7, 9, 11, 13, 15]
int | search -> 11
int | lo -> 0
int | hi -> len(arr) - 1
int | found_at -> -1
int | mid -> 0

while lo <= hi {
    mid = (lo + hi) / 2
    
    if arr[mid] == search {
        found_at = mid
        break
    } else if arr[mid] < search {
        lo = mid + 1
    } else {
        hi = mid - 1
    }
}

out("Found", search, "at index:", found_at)

# 4. Bit Counting Pattern (WHILE_NONZERO)
out("\n=== BIT COUNTING PATTERN ===")
int | n -> 42
int | count -> 0

while n != 0 {
    count = count + (n & 1)
    n = n >> 1
}

out("Number of 1-bits in 42:", count)

# 5. Power of 2 Check
out("\n=== POWER OF 2 CHECK ===")
int | num -> 16
bool | is_pow2 -> num > 0 and (num & (num - 1)) == 0
out("Is 16 a power of 2?", is_pow2)

num = 18
is_pow2 = num > 0 and (num & (num - 1)) == 0
out("Is 18 a power of 2?", is_pow2)

out("\n========================================")
out("ALL ALGORITHM PATTERNS WORK!")
out("========================================")
