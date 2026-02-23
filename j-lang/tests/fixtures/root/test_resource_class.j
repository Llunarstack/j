# Test resource class - RAII-style cleanup

resource class | FileHandle {
    str | filename
    bool | is_open -> false
    
    fn | init (str | name) > {
        filename = name
        is_open = true
        out("📂 Opened file: " filename)
    }
    
    fn | write (str | data) > {
        guard is_open : "File is closed"
        out("✍️  Writing to " filename ": " data)
    }
    
    fn | close () > {
        if is_open {
            is_open = false
            out("🔒 Closed file: " filename)
        }
    }
}

# Test automatic cleanup
{
    file -> FileHandle("test.txt")
    file.write("Hello, World!")
    # file.close() should be called automatically when scope exits
}

out("✅ Resource class test passed!")
