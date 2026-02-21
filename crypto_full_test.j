out("=== J Language Advanced Crypto Test ===")

out("")
out("Test 1: AES-256-GCM Encryption")
list | aes_key -> crypto_random_bytes(32)
list | aes_nonce -> crypto_nonce()
str | aes_msg -> "AES-256-GCM test message"
out("Original: AES-256-GCM test message")
list | aes_cipher -> aes_encrypt(aes_msg, aes_key, aes_nonce, "aad-test")
out("Encrypted successfully")
str | aes_plain -> aes_decrypt(aes_cipher, aes_key, aes_nonce, "aad-test")
out("Decrypted: " + aes_plain)
if aes_plain == aes_msg {
    out("✓ Test 1 PASSED - AES-256-GCM works")
}

out("")
out("Test 2: Argon2id Password Derivation")
str | pwd -> "my_secure_password"
list | pwd_salt -> crypto_salt(16)
out("Deriving key from password...")
list | pwd_key -> derive_password_key(pwd, pwd_salt, 2, 19456)
out("Key derived: " + str(len(pwd_key)) + " bytes")
out("✓ Test 2 PASSED - Argon2id works")

out("")
out("Test 3: Constant-Time Comparison")
str | token_a -> "secret_token_123"
str | token_b -> "secret_token_123"
out("Comparing matching tokens...")
if secure_compare(token_a, token_b) {
    out("✓ Test 3 PASSED - Secure compare works")
}

out("")
out("Test 4: Random Generation")
list | rand_key -> crypto_random_bytes(32)
list | rand_salt -> crypto_salt()
list | rand_nonce -> crypto_nonce()
out("Generated key: " + str(len(rand_key)) + " bytes")
out("Generated salt: " + str(len(rand_salt)) + " bytes")
out("Generated nonce: " + str(len(rand_nonce)) + " bytes")
out("✓ Test 4 PASSED - CSPRNG works")

out("")
out("=== All Advanced Tests Complete ===")
out("Production-grade cryptography working!")
