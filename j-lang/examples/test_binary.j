# Test binary search loop
out("Testing binary search")

list | arr -> [1, 3, 5, 7, 9, 11, 13, 15]
int | target -> 11
int | result -> -1

binary (lo, hi) in arr {
    int | mid -> (lo + hi) / 2
    
    out("lo:", lo, "hi:", hi, "mid:", mid)
    
    if arr[mid] == target {
        result = mid
        lo = lo
        hi = hi
    } else {
        if arr[mid] < target {
            lo = mid + 1
        } else {
            hi = mid - 1
        }
    }
}

out("Result:", result)
