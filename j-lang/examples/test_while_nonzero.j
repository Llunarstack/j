# Test while_nonzero
out("Testing while_nonzero")

int | num -> 42
int | count -> 0

while_nonzero num {
    count = count + (num & 1)
    num = num >> 1
}

out("Count:", count)
