# Test each class type individually

out("Testing regular class...")
class | Regular {
  int | x -> 0
}
out("✓ Regular class works")

out("Testing data class...")
data class | DataClass {
  int | x -> 0
}
out("✓ Data class works")

out("Testing singleton class...")
singleton class | Singleton {
  int | x -> 0
}
out("✓ Singleton class works")

out("Testing actor class...")
actor class | Actor {
  int | x -> 0
}
out("✓ Actor class works")

out("Testing threadsafe class...")
threadsafe class | Threadsafe {
  int | x -> 0
}
out("✓ Threadsafe class works")

out("Testing observable class...")
observable class | Observable {
  int | x -> 0
}
out("✓ Observable class works")

out("Testing secure class...")
secure class | Secure {
  int | x -> 0
}
out("✓ Secure class works")

out("Testing resource class...")
resource class | Resource {
  int | x -> 0
}
out("✓ Resource class works")

out("")
out("All class types work!")
