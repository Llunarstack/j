# Test sweep loop
out("Testing sweep loop")

list | nums -> [1, 2, 3, 4, 5]

sweep (left, right) in nums {
    out("left:", left, "right:", right)
    right = right + 1
}

out("Done")
