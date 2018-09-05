import Foundation

struct Point {
	static let zero = Point(0, 0, 0)
	let x: Double, y: Double, z: Double
	
	init(_ x: Double, _ y: Double, _ z: Double) {
		self.x = x
		self.y = y
		self.z = z
	}
	
	init(_ x: Double, _ y: Double) {
		self = Point(x, y, 0)
	}
	
	func distance(to point: Point) -> Double {
		return sqrt(pow(point.x - x, 2) + pow(point.y - y, 2) + pow(point.z - z, 2))
	}
}

extension Point: CustomStringConvertible {
	var description: String {
		get { return "Point(\(x), \(y), \(z))" }
	}
}

extension Point { //Operator overloads
	static func +(_ lhs: Point, _ rhs: Point) -> Point {
		return Point(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
	}
	
	static func -(_ lhs: Point, _ rhs: Point) -> Point {
		return Point(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
	}
}

struct Vector {
	static let zero = Vector(0, 0, 0)
	static let i = Vector(1, 0, 0), j = Vector(0, 1, 0), k = Vector(0, 0, 1)
	
	let origin: Point, components: Point
	var tip: Point {
		get { return origin + components }
	}
	
	init(origin: Point, components: Point) {
		self.origin = origin
		self.components = components
	}
	
	init(_ components: Point) {
		self = Vector(origin: .zero, components: components)
	}
	
	init(_ x: Double, _ y: Double, _ z: Double) {
		self = Vector(Point(x, y, z))
	}
	
	init(_ x: Double, _ y: Double) {
		self = Vector(x, y, 0)
	}
	
	init(origin: Point, tip: Point) {
		self = Vector(origin: origin, components: tip - origin)
	}
	
	func normalized() -> Vector {
		return self / self.magnitude()
	}
	
	mutating func normalize() {
		self = self.normalized()
	}
	
	func magnitude() -> Double {
		return origin.distance(to: tip)
	}
	
	func dot(_ v: Vector) -> Double {
		return components.x * v.components.x + components.y * v.components.y + components.z * v.components.z
	}
	
	func internalAngle(with v: Vector) -> Double {
		let angle = acos(self.dot(v) / (self.magnitude() * v.magnitude()))
		return angle.isNaN ? .pi : angle // returns NaN if resulting angle is 180deg
	}
	
	func scalarProjection(on v: Vector) -> Double {
		return self.dot(v.normalized())
	}
	
	func vectorProjection(on v: Vector) -> Vector {
		return v.normalized() * self.scalarProjection(on: v)
	}
	
	func cross(_ v: Vector) -> Vector {
		return Vector(components.y * v.components.z - components.z * v.components.y,
					-(components.x * v.components.z - components.z * v.components.x),
					  components.x * v.components.y - components.y * v.components.x)
	}
}

extension Vector: CustomStringConvertible {
	var description: String {
		get { return "Vector(origin: \(origin), components: \(components))" }
	}
}

extension Vector { //Operator overloads
	static func +(_ lhs: Vector, _ rhs: Vector) -> Vector {
		return Vector(origin: lhs.origin, components: Point(lhs.components.x + rhs.components.x,
															lhs.components.y + rhs.components.y,
															lhs.components.z + rhs.components.z))
	}
	
	static func *(_ lhs: Vector, _ scale: Double) -> Vector {
		return Vector(origin: lhs.origin, components: Point(lhs.components.x * scale, lhs.components.y * scale, lhs.components.z * scale))
	}
	
	static func /(_ lhs: Vector, _ rhs: Double) -> Vector {
		return Vector(origin: lhs.origin, components: Point(lhs.components.x / rhs, lhs.components.y / rhs, lhs.components.z / rhs))
	}
	
	static prefix func -(_ v: Vector) -> Vector {
		return v * -1
	}
	
	static func -(_ lhs: Vector, _ rhs: Vector) -> Vector {
		return lhs + -rhs
	}
}

func parallelepipedExample() {
	// Find the volume of the parallelepiped with adjacent edges PQ, PR, and PS.
	// P(−2, 1, 0), Q(4, 5, 4), R(1, 4, −1), S(3, 6, 2)
	let p = Point(-2, 1, 0), q = Point(4, 5, 4), r = Point(1, 4, -1), s = Point(3, 6, 2)
	let pq = Vector(origin: p, tip: q), pr = Vector(origin: p, tip: r), ps = Vector(origin: p, tip: s)
	
	print(ps.dot(pq.cross(pr)))
}

func distanceFromPointToLineExample() {
	// Use the formula
	// d = |a x b| / |a|
	// to find the distance from the point P(1, 1, 1) to the line through Q(0, 6, 9) and R(−1, 3, 6).
	let p = Point(1, 1, 1), q = Point(0, 6, 9), r = Point(-1, 3, 6)
	let a = Vector(origin: q, tip: r), b = Vector(origin: q, tip: p)
	print(a.cross(b).magnitude() / a.magnitude())
}


