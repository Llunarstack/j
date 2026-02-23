# Test secure class - encrypted fields by default

secure class | Vault {
    enc<str> | master_password_hash
    enc<dict> | secrets
    
    fn | init (str | password) > {
        master_password_hash = password.password_hash()
        secrets = enc({})
    }
    
    fn | store (str | key, str | value, str | password) > {
        guard master_password_hash.password_verify(password) : "Wrong password"
        secrets[key] = value
        out("🔐 Stored secret: " key)
    }
    
    fn | get (str | key, str | password) > {
        guard master_password_hash.password_verify(password) : "Wrong password"
        secrets[key] or "not found"
    }
}

# Create vault
vault -> Vault("my_secret_password")

# Store secrets
vault.store("api_key", "sk-1234567890", "my_secret_password")
vault.store("db_password", "super_secret", "my_secret_password")

# Retrieve secrets
api_key -> vault.get("api_key", "my_secret_password")
out("Retrieved API key: " api_key)

# Try wrong password (should fail)
# wrong -> vault.get("api_key", "wrong_password")  # Should panic

out("✅ Secure class test passed!")
