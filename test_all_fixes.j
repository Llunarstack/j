out("=== Comprehensive Fix Verification ===")

out("")
out("Test 1: Loop Assignment Scoping")
int | i -> 0
while i < 5 {
    i = i + 1
}
out("Loop counter: " + str(i))

out("")
out("Test 2: Cross-Type Arithmetic")
int | x -> 10
float | y -> 3.5
out("10 + 3.5 = " + str(x + y))
out("10 * 3.5 = " + str(x * y))

out("")
out("Test 3: Cross-Type Equality")
int | a -> 5
float | b -> 5.0
if a == b {
    out("5 == 5.0: true")
}

out("")
out("Test 4: String Concatenation")
out("Number: " + 42)
out("Float: " + 3.14)
out("Bool: " + true)

out("")
out("Test 5: Crypto Functions")
list | key -> crypto_random_bytes(32)
list | nonce -> crypto_nonce()
str | msg -> "test"
list | enc -> enigma_encrypt(msg, key, nonce, "")
str | dec -> enigma_decrypt(enc, key, nonce, "")
out("Crypto: " + dec)

out("")
out("=== All Tests Complete ===")
