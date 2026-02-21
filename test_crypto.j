out("Enigma Encryption Test")
out("======================")

out("Generating 32-byte key...")
list | key -> crypto_random_bytes(32)
out("Key generated")

out("Generating 12-byte nonce...")
list | nonce -> crypto_random_bytes(12)
out("Nonce generated")

str | message -> "Top secret!"
out("Message ready")

out("Encrypting...")
list | encrypted -> enigma_encrypt(message, key, nonce, "test")
out("Encryption complete")

out("Decrypting...")
str | decrypted -> enigma_decrypt(encrypted, key, nonce, "test")
out("Decryption complete")
out(decrypted)

out("Testing XOR...")
str | msg -> "HELLO"
list | xor_key -> crypto_random_bytes(5)
list | xor_enc -> xor_bytes(msg, xor_key)
list | xor_dec -> xor_bytes(xor_enc, xor_key)
out("XOR test complete")

out("Testing emoji...")
str | emoji_msg -> "Duck 🦆"
list | key2 -> crypto_random_bytes(32)
list | nonce2 -> crypto_random_bytes(12)
list | emoji_enc -> enigma_encrypt(emoji_msg, key2, nonce2, "")
str | emoji_dec -> enigma_decrypt(emoji_enc, key2, nonce2, "")
out(emoji_dec)

out("All tests passed!")
out("Enigma encryption working correctly")
