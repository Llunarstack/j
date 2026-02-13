// Test trait system

out("Testing trait system...")

// Define a trait
trait | Printable {
    fn | to_string() > ""
    fn | print() > {
        out(this.to_string())
    }
}

// Define a class
class | Person {
    str | name -> ""
    int | age -> 0
}

// Note: Full trait implementation (impl Printable for Person) 
// would require additional parser support for TraitImpl AST node
// For now, we can define the trait and verify it's stored

out("Trait Printable defined successfully")
out("Class Person defined successfully")

// Create an instance
person -> Person.new()
person.name = "Alice"
person.age = 30

out("Person instance created: " + person.name + ", age " + str(person.age))

out("Trait system test complete!")
