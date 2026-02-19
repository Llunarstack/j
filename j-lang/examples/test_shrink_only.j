# Test shrink loop only
list | nums -> [1, 2, 3, 4, 5]

shrink (left, right) in nums {
    out("left:", left, "right:", right)
    left = left + 1
}
