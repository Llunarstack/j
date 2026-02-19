# Test DP loop with fibonacci
out("Testing DP Fibonacci")

int | n -> 10

dp fibonacci[n] = 0 {
    fibonacci[0] = 0
    fibonacci[1] = 1
    
    i in 2 .. n {
        fibonacci[i] = fibonacci[i-1] + fibonacci[i-2]
    }
}

out("Result:", fibonacci)
