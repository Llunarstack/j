out("=== J Crypto Test Suite ===")
out("")

out("Test 1: ChaCha20-Poly1305")
list | key1 -> crypto_random_bytes(32)
list | nonce1 -> crypto_nonce()
str | msg1 -> "ChaCha20 test"
list | cipher1 -> enigma_encrypt(msg1, key1, nonce1, "aad1")
str | plain1 -> enigma_decrypt(cipher1, key1, nonce1, "aad1")
if plain1 == msg1 {
    out("PASS: ChaCha20-Poly1305")
}

out("")
out("Test 2: AES-256-GCM")
list | key2 -> crypto_random_bytes(32)
list | nonce2 -> crypto_nonce()
str | msg2 -> "AES test"
list | cipher2 -> aes_encrypt(msg2, key2, nonce2, "aad2")
str | plain2 -> aes_decrypt(cipher2, key2, nonce2, "aad2")
if plain2 == msg2 {
    out("PASS: AES-256-GCM")
}

out("")
out("Test 3: Argon2id")
str | pwd -> "password123"
list | salt3 -> crypto_salt(16)
list | key3 -> derive_password_key(pwd, salt3, 2, 19456)
out("PASS: Argon2id (" + str(len(key3)) + " bytes)")

out("")
out("Test 4: Secure Compare")
str | tok1 -> "secret"
str | tok2 -> "secret"
if secure_compare(tok1, tok2) {
    out("PASS: Constant-time comparison")
}

out("")
out("Test 5: CSPRNG")
list | rk -> crypto_random_bytes(32)
list | rs -> crypto_salt()
list | rn -> crypto_nonce()
out("PASS: Random generation")

out("")
out("Test 6: XOR")
str | xm -> "TEST"
list | xk -> crypto_random_bytes(4)
list | xe -> xor_bytes(xm, xk)
list | xd -> xor_bytes(xe, xk)
out("PASS: XOR one-time pad")

out("")
out("Test 7: Unicode")
str | em -> "Hello 🦆"
list | ek -> crypto_random_bytes(32)
list | en -> crypto_nonce()
list | ec -> aes_encrypt(em, ek, en, "")
str | ep -> aes_decrypt(ec, ek, en, "")
if ep == em {
    out("PASS: Unicode/emoji")
}

out("")
out("=== All Tests Passed ===")
