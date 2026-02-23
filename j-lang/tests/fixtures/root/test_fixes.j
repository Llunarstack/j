out("Testing fixes")

out("1. Assignment in loop")
int | cnt -> 0
while cnt < 3 {
    cnt = cnt + 1
}
out("Counter: " + str(cnt))

out("2. Cross-type math")
int | a -> 5
float | b -> 2.5
float | c -> a + b
out("Result: " + str(c))

out("3. Cross-type comparison")
int | i -> 5
float | f -> 5.0
if i == f {
    out("5 == 5.0 is true")
}

out("Done")
