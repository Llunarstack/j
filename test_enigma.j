out("Testing enigma encryption...")

list | key -> crypto_random_bytes(32)
out("Key generated")

list | nonce -> crypto_random_bytes(12)
out("Nonce generated")

str | message -> "Hello World"
out("Message: " + message)

list | encrypted -> enigma_encrypt(message, key, nonce, "test")
out("Encrypted successfully")

str | decrypted -> enigma_decrypt(encrypted, key, nonce, "test")
out("Decrypted: " + decrypted)
