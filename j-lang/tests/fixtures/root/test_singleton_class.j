# Test singleton class - only one instance ever

singleton class | AppConfig {
    dict | settings -> { theme: "dark", log_level: "info" }
    
    fn | get (str | key) > settings[key]
    
    fn | set (str | key, value) > {
        settings[key] = value
    }
}

# Create first instance
config1 -> AppConfig()
out("Config1 theme: " config1.get("theme"))

# Modify it
config1.set("theme", "light")

# Create "second" instance - should be same as first
config2 -> AppConfig()
out("Config2 theme: " config2.get("theme"))  # Should be "light"

# Verify they're the same instance
config2.set("log_level", "debug")
out("Config1 log_level: " config1.get("log_level"))  # Should be "debug"

out("✅ Singleton test passed!")
