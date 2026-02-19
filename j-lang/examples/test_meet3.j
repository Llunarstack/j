# Test meet loop
out("Testing meet loop")

list | sorted -> [1, 2, 3, 4, 5]

meet (l, r) in sorted {
    out("l:", l, "r:", r)
    l = l + 1
}

out("Done")
