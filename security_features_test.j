out("=== J Security Features Demo ===")

out("")
out("Feature 1: Encrypted Values")
str | data -> "confidential"
out("Original: confidential")
val -> encrypt_value(data, "master-key")
out("Type: " + type(val))
str | dec -> decrypt_value(val)
out("Decrypted: " + dec)
out("✓ Encrypted values work")

out("")
out("Feature 2: Secret Redaction")
tok -> make_secret("sk_live_abc123")
out("Secret: " + str(tok))
str | rev -> reveal_secret(tok)
out("Revealed: " + rev)
out("✓ Secret redaction works")

out("")
out("Feature 3: Audit Logging")
audit_log("user_login", "ethan")
audit_log("data_access", "file.txt")
out("✓ Audit logging works")

out("")
out("=== Security Features Complete ===")
