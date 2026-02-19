// Working Algorithm Demonstrations

out("==========================================")
out("   LeetCode-Style Algorithms in J")
out("==========================================")
out("")

// Maximum Subarray - Kadane's Algorithm
out("=== Maximum Subarray (Kadane's) ===")
list | arr -> [-2, 1, -3, 4, -1, 2, 1, -5, 4]
int | max_sum -> -999
int | curr_sum -> 0
int | i -> 0

while i < len(arr) {
    curr_sum -> curr_sum + arr[i]
    if curr_sum > max_sum {
        max_sum -> curr_sum
    }
    if curr_sum < 0 {
        curr_sum -> 0
    }
    i -> i + 1
}

out("Array: [-2, 1, -3, 4, -1, 2, 1, -5, 4]")
out("Max sum:")
out(max_sum)
out("")

// Binary Search
out("=== Binary Search ===")
list | sorted -> [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]
int | target -> 13
int | left -> 0
int | right -> len(sorted) - 1
int | found_at -> -1

while left <= right {
    int | mid -> left + (right - left) / 2
    if sorted[mid] == target {
        found_at -> mid
        break
    }
    if sorted[mid] < target {
        left -> mid + 1
    } else {
        right -> mid - 1
    }
}

out("Array: [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]")
out("Target: 13")
out("Found at index:")
out(found_at)
out("")

// Fibonacci with DP
out("=== Fibonacci (DP) ===")
int | n -> 10
list | fib -> [0, 1]
i -> 2

while i <= n {
    int | next -> fib[i-1] + fib[i-2]
    fib.push(next)
    i -> i + 1
}

out("Fib(10):")
out(fib[n])
out("")

// Palindrome Check
out("=== Palindrome Check ===")
str | word1 -> "racecar"
str | word2 -> "hello"

// Check word1
int | l -> 0
int | r -> len(word1) - 1
bool | is_pal1 -> true

while l < r {
    if word1[l] != word1[r] {
        is_pal1 -> false
        break
    }
    l -> l + 1
    r -> r - 1
}

// Check word2
l -> 0
r -> len(word2) - 1
bool | is_pal2 -> true

while l < r {
    if word2[l] != word2[r] {
        is_pal2 -> false
        break
    }
    l -> l + 1
    r -> r - 1
}

out("'racecar' is palindrome:")
out(is_pal1)
out("'hello' is palindrome:")
out(is_pal2)
out("")

// Find Maximum
out("=== Find Maximum ===")
list | numbers -> [3, 7, 2, 9, 1, 5, 8]
int | max_val -> numbers[0]
i -> 1

while i < len(numbers) {
    if numbers[i] > max_val {
        max_val -> numbers[i]
    }
    i -> i + 1
}

out("Array: [3, 7, 2, 9, 1, 5, 8]")
out("Maximum:")
out(max_val)
out("")

// Reverse Array
out("=== Reverse Array ===")
list | original -> [1, 2, 3, 4, 5]
list | reversed -> []
i -> len(original) - 1

while i >= 0 {
    reversed.push(original[i])
    i -> i - 1
}

out("Original: [1, 2, 3, 4, 5]")
out("Reversed:")
out(reversed)
out("")

// Prime Check
out("=== Prime Number Check ===")
int | num -> 17
bool | is_prime -> true

if num <= 1 {
    is_prime -> false
} else {
    i -> 2
    while i * i <= num {
        if num % i == 0 {
            is_prime -> false
            break
        }
        i -> i + 1
    }
}

out("Number: 17")
out("Is prime:")
out(is_prime)
out("")

// Factorial
out("=== Factorial ===")
int | fact_n -> 10
int | factorial -> 1
i -> 1

while i <= fact_n {
    factorial -> factorial * i
    i -> i + 1
}

out("Factorial of 10:")
out(factorial)
out("")

out("==========================================")
out("      All Algorithms Complete!")
out("==========================================")
