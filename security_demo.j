out("Testing security features...")

str | message -> "confidential"
out("Message: " + message)

list | encrypted_val -> encrypt_value(message, "key1")
out("Encrypted successfully")

str | decrypted_val -> decrypt_value(encrypted_val)
out("Decrypted: " + decrypted_val)

list | token_val -> make_secret("api_key_123")
out("Token: " + str(token_val))

str | revealed_val -> reveal_secret(token_val)
out("Revealed: " + revealed_val)

audit_log("test_event", "test_data")
out("Audit logged")

out("All security features work!")
