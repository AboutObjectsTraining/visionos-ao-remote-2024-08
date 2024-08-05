struct Point: CustomStringConvertible {
    var x: Double
    var y: Double
    
    var description: String {
        return "x: \(x), y: \(y)"
    }
}

struct Size: CustomStringConvertible {
    var width: Double
    var height: Double
    
    var description: String {
        return "width: \(width), height: \(height)"
    }
}

struct Rectangle: CustomStringConvertible {
    // Stored properties
    var origin: Point
    var size: Size
    
    // Computed properties
    var x: Double { origin.x }
    var y: Double { origin.y }
    var width: Double  { size.width }
    var height: Double { size.height }
    
    var description: String { "\(origin), \(size)" }
    
    var area: Double { width * height }
    
    var center: Point {
         Point(x: (x + width) / 2,
               y: (y + height) / 2)
    }
    
    // Methods
    func offsetBy(dx: Double, dy: Double) -> Rectangle {
        let newOrigin = Point(x: x + dx, y: y + dy)
        return Rectangle(origin: newOrigin, size: size)
    }
}
