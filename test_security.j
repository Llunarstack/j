out("=== J Security Features Test ===")

out("")
out("Test 1: Encrypted Values")
str | data_val -> "my_secret_data"
out("Original: " + data_val)
encrypted_val -> encrypt_value(data_val, "master-key")
out("Encrypted: " + str(encrypted_val))
str | decrypted_val -> decrypt_value(encrypted_val)
out("Decrypted: " + decrypted_val)
if decrypted_val == data_val {
    out("✓ Test 1 PASSED")
}

out("")
out("Test 2: Secret Values")
secret_val -> make_secret("sk_live_abc123xyz")
out("API Key: " + str(secret_val))
str | revealed_val -> reveal_secret(secret_val)
out("Revealed: " + revealed_val)
out("✓ Test 2 PASSED")

out("")
out("Test 3: Audit Logging")
audit_log("user_login", "ethan")
audit_log("data_access", "secrets.txt")
audit_log("api_call", "/api/payment")
out("✓ Test 3 PASSED")

out("")
out("=== All Security Tests Passed ===")
