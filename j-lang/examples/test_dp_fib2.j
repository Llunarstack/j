# Test DP loop with fibonacci
out("Testing DP Fibonacci")

dp fibonacci[10] = 0 {
    fibonacci[0] = 0
    fibonacci[1] = 1
    
    i in 2 .. 10 {
        fibonacci[i] = fibonacci[i-1] + fibonacci[i-2]
    }
}

out("Result:", fibonacci)
