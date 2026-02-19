# Test shrink loop no space
out("Testing shrink loop")

list | sorted -> [1, 2, 3, 4, 5]

shrink(left,right)in sorted{out("left:",left,"right:",right)left=left+1}

out("Done")
