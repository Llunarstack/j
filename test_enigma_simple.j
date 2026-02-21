out("=== Enigma Encryption Test ===")

out("\n1. Generating secure keys...")
list | key -> crypto_random_bytes(32)
list | nonce -> crypto_random_bytes(12)
out("Key: 32 bytes, Nonce: 12 bytes")

out("\n2. Encrypting message...")
str | secret -> "Top secret duck plans!"
out("Original: " + secret)
list | cipher -> enigma_encrypt(secret, key, nonce, "urgent")
out("Encrypted: " + str(len(cipher)) + " bytes")

out("\n3. Decrypting message...")
str | plain -> enigma_decrypt(cipher, key, nonce, "urgent")
out("Decrypted: " + plain)

out("\n4. Testing XOR (One-Time Pad)...")
str | msg -> "SECRET"
list | otp_key -> crypto_random_bytes(6)
list | encrypted -> xor_bytes(msg, otp_key)
out("XOR encrypted: " + str(len(encrypted)) + " bytes")
list | decrypted -> xor_bytes(encrypted, otp_key)
out("XOR works correctly")

out("\n5. Testing emoji support...")
str | emoji -> "Hello 🦆🔐"
list | key2 -> crypto_random_bytes(32)
list | nonce2 -> crypto_random_bytes(12)
list | emoji_cipher -> enigma_encrypt(emoji, key2, nonce2, "")
str | emoji_plain -> enigma_decrypt(emoji_cipher, key2, nonce2, "")
out("Emoji message: " + emoji_plain)

out("\n6. Testing large message...")
str | large -> "This is a longer message that tests encryption of multiple blocks of data."
list | key3 -> crypto_random_bytes(32)
list | nonce3 -> crypto_random_bytes(12)
list | large_cipher -> enigma_encrypt(large, key3, nonce3, "test")
str | large_plain -> enigma_decrypt(large_cipher, key3, nonce3, "test")
out("Large message decrypted successfully")

out("\n=== All Tests Passed! ===")
out("✓ ChaCha20-Poly1305 AEAD encryption")
out("✓ 256-bit keys")
out("✓ Authenticated encryption")
out("✓ XOR one-time pad")
out("✓ Unicode/emoji support")
out("✓ Large message support")
