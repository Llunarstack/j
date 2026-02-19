# Test meet loop
out("Testing meet loop")

list | sorted -> [1, 2, 3, 4, 5, 6, 7, 8, 9]
int | sum_target -> 10
bool | found -> false
int | current_sum -> 0

meet (l, r) in sorted {
    current_sum = sorted[l] + sorted[r]
    
    if current_sum == sum_target {
        out("Found:", sorted[l], "+", sorted[r], "=", sum_target)
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

out("Done, found:", found)
