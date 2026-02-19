# BINARY SEARCH AND DP LOOP DEMONSTRATIONS

out("========================================")
out("BINARY SEARCH & DP LOOPS")
out("========================================\n")

# 1. BINARY SEARCH LOOP - Find exact match
out("=== BINARY SEARCH - Find Element ===")
list | arr -> [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]
int | target -> 13
int | result -> -1

binary (lo, hi) in arr {
    int | mid -> (lo + hi) / 2
    int | mid_val -> arr[mid]
    
    out("Searching: lo=", lo, "hi=", hi, "mid=", mid, "val=", mid_val)
    
    if mid_val == target {
        result = mid
        lo = lo
        hi = hi
    } else {
        if mid_val < target {
            lo = mid + 1
        } else {
            hi = mid - 1
        }
    }
} else {
    out("Not found!")
}

if result >= 0 {
    out("Found", target, "at index", result)
}

# 2. BINARY SEARCH - Find insertion point
out("\n=== BINARY SEARCH - Insertion Point ===")
list | arr2 -> [1, 3, 5, 7, 9]
int | target2 -> 6
int | insert_pos -> 0

binary (lo2, hi2) in arr2 {
    int | mid2 -> (lo2 + hi2) / 2
    
    if arr2[mid2] < target2 {
        insert_pos = mid2 + 1
        lo2 = mid2 + 1
    } else {
        hi2 = mid2 - 1
    }
}

out("Insert", target2, "at position", insert_pos)

# 3. DP LOOP - 1D Fibonacci
out("\n=== DP LOOP - Fibonacci (1D) ===")
int | n -> 10

dp fib[n] = 0 {
    fib[0] = 0
    fib[1] = 1
    
    i in 2 .. n {
        fib[i] = fib[i-1] + fib[i-2]
    }
}

out("Fibonacci(0-9):", fib)

# 4. DP LOOP - 2D Grid paths
out("\n=== DP LOOP - Grid Paths (2D) ===")
int | rows -> 3
int | cols -> 4

dp paths[rows][cols] = 0 {
    paths[0][0] = 1
    
    i in 0 .. rows {
        j in 0 .. cols {
            if i > 0 {
                paths[i][j] = paths[i][j] + paths[i-1][j]
            }
            if j > 0 {
                paths[i][j] = paths[i][j] + paths[i][j-1]
            }
        }
    }
}

out("Grid paths (3x4):")
i in 0 .. rows {
    out("Row", i, ":", paths[i])
}

out("\n========================================")
out("BINARY & DP LOOPS COMPLETE!")
out("========================================")
