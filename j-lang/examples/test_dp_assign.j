# Test DP loop with assignment
out("Testing DP with assignment")

dp table[5] = 0 {
    table[0] = 1
    out("Assigned")
}

out("Result:", table)
