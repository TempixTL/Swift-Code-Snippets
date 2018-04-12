class Person: CustomStringConvertible {
	let firstName: String
	let lastName: String
	let age: Int
	
	init(_ firstName: String, _ lastName: String, _ age: Int) {
		self.firstName = firstName
		self.lastName = lastName
		self.age = age
	}
	
	public var description: String {
		return "\(firstName) \(lastName) is \(age) years old"
	}
}

let emerson = Person("Emerson", "Spradling", 18)
print(emerson)