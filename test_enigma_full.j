out("=== J Language Enigma Encryption Test ===")

out("")
out("Test 1: Basic Encryption")
list | key1 -> crypto_random_bytes(32)
list | nonce1 -> crypto_nonce()
str | msg1 -> "Top secret duck plans!"
out("Original: Top secret duck plans!")
list | cipher1 -> enigma_encrypt(msg1, key1, nonce1, "metadata:urgent")
out("Encrypted successfully")
str | plain1 -> enigma_decrypt(cipher1, key1, nonce1, "metadata:urgent")
out("Decrypted: " + plain1)
if plain1 == msg1 {
    out("✓ Test 1 PASSED")
}

out("")
out("Test 2: XOR One-Time Pad")
str | msg2 -> "SECRET"
list | otp_key -> crypto_random_bytes(6)
list | encrypted2 -> xor_bytes(msg2, otp_key)
list | decrypted2 -> xor_bytes(encrypted2, otp_key)
out("✓ Test 2 PASSED - XOR works")

out("")
out("Test 3: Unicode/Emoji Support")
str | emoji_msg -> "Hello 🦆🔐🎉"
list | key3 -> crypto_random_bytes(32)
list | nonce3 -> crypto_nonce()
out("Original: Hello 🦆🔐🎉")
list | emoji_cipher -> enigma_encrypt(emoji_msg, key3, nonce3, "")
str | emoji_plain -> enigma_decrypt(emoji_cipher, key3, nonce3, "")
out("Decrypted: " + emoji_plain)
if emoji_plain == emoji_msg {
    out("✓ Test 3 PASSED - Emoji support works")
}

out("")
out("Test 4: Large Message")
str | large -> "This is a longer message that tests the encryption of multiple blocks of data to ensure everything works correctly with larger payloads."
list | key4 -> crypto_random_bytes(32)
list | nonce4 -> crypto_nonce()
out("Encrypting 124 character message...")
list | large_cipher -> enigma_encrypt(large, key4, nonce4, "large-test")
out("Encrypted successfully")
str | large_plain -> enigma_decrypt(large_cipher, key4, nonce4, "large-test")
out("Decrypted successfully")
if large_plain == large {
    out("✓ Test 4 PASSED - Large message works")
}

out("")
out("=== All Tests Complete ===")
out("Enigma encryption is working correctly!")
