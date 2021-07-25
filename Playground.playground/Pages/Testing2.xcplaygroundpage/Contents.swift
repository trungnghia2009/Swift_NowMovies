import Foundation

struct Point: Equatable {
    var x, y: Double
}

struct Size: Equatable {
    var width, height: Double
}

struct Rectangle: Equatable {
    var origin: Point
    var size: Size
}

extension Point {
    private func flipped() -> Self {
        Point(x: y, y: x)
    }
    
    mutating func flip() {
        self = flipped()
    }
}

extension Point {
    static var zero: Point {
        Point(x: 0, y: 0)
    }
    
    static func random(inRadius radius: Double) -> Point {
        guard radius >= 0 else { return .zero }
        
        let x = Double.random(in: -radius...radius)
        let maxY = (radius * radius - x * x).squareRoot()
        let y = Double.random(in: -maxY...maxY)
        return Point(x: x, y: y)
    }
}

enum Quadrant: CaseIterable, Hashable {
    case i, ii, iii, iv
    
    init?(_ point: Point) {
        guard !point.x.isZero && !point.y.isZero else { return nil }
        
        switch (point.x.sign, point.y.sign) {
        case (.plus, .plus):
            self = .i
        case (.minus, .plus):
            self = .ii
        case (.minus, .minus):
            self = .iii
        case (.plus, .minus):
            self = .iv
        }
    }
}

let quadrant = Quadrant(Point(x: -2, y: 5))
Quadrant(.zero)

let dictionary: Dictionary<Int, String> = [1: "Dog", 2: "Cat"]
let data = dictionary[4]
var set: Set<Quadrant> = [.i, .ii, .iii, .iv]

let a = 5
a.hashValue
a.hashValue
