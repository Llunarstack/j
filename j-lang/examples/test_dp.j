# Test DP loop
out("Testing DP loop")

int | n -> 10

dp fib[n] = 0 {
    fib[0] = 0
    fib[1] = 1
    
    i in 2 .. n {
        fib[i] = fib[i-1] + fib[i-2]
    }
}

out("Fibonacci:", fib)
