# Test meet loop
out("Testing meet loop")

list | sorted -> [1, 2, 3, 4, 5]

meet (left, right) in sorted {
    out("left:", left, "right:", right)
    left = left + 1
}

out("Done")
