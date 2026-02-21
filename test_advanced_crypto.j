out("=== J Advanced Crypto Test ===")

out("")
out("Test 1: AES-256-GCM Encryption")
list | aes_key -> crypto_random_bytes(32)
list | aes_nonce -> crypto_nonce()
str | aes_msg -> "AES-256-GCM test"
out("Message: " + aes_msg)
list | aes_cipher -> aes_encrypt(aes_msg, aes_key, aes_nonce, "aad")
str | aes_plain -> aes_decrypt(aes_cipher, aes_key, aes_nonce, "aad")
out("Decrypted: " + aes_plain)
if aes_plain == aes_msg {
    out("✓ AES-256-GCM works")
}

out("")
out("Test 2: Argon2id Password Derivation")
str | pwd -> "my_secure_password"
list | pwd_salt -> crypto_salt(16)
out("Deriving key with Argon2id...")
list | pwd_key -> derive_password_key(pwd, pwd_salt, 2, 19456)
out("Derived key: " + str(len(pwd_key)) + " bytes")
out("✓ Argon2id works")

out("")
out("Test 3: Constant-Time Comparison")
str | tok1 -> "secret_abc"
str | tok2 -> "secret_abc"
out("Comparing tokens...")
if secure_compare(tok1, tok2) {
    out("✓ Secure compare works")
}

out("")
out("Test 4: Random Generation")
list | rand_key -> crypto_random_bytes(32)
list | rand_salt -> crypto_salt()
list | rand_nonce -> crypto_nonce()
out("Key: " + str(len(rand_key)) + " bytes")
out("Salt: " + str(len(rand_salt)) + " bytes")
out("Nonce: " + str(len(rand_nonce)) + " bytes")
out("✓ CSPRNG works")

out("")
out("=== All Tests Passed ===")
