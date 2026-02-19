# Test all advanced loops one by one

# 1. SWEEP
out("=== SWEEP ===")
list | nums1 -> [1, 2, 3, 4, 5]
sweep (left1, right1) in nums1 {
    out("left:", left1, "right:", right1)
    right1 = right1 + 1
}

# 2. MEET
out("\n=== MEET ===")
list | nums2 -> [1, 2, 3, 4, 5]
meet (left2, right2) in nums2 {
    out("left:", left2, "right:", right2)
    left2 = left2 + 1
}

# 3. SHRINK
out("\n=== SHRINK ===")
list | nums3 -> [1, 2, 3, 4, 5]
shrink (left3, right3) in nums3 {
    out("left:", left3, "right:", right3)
    left3 = left3 + 1
}

out("\nDone!")
