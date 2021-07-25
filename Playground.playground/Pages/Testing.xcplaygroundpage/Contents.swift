import Foundation

struct StructPoint {
    var x, y: Double
}

extension StructPoint {
    
    init(doge: Double, cat: Double) {
        self.x = doge*10
        self.y = cat*10
    }
}

class ClassPoint {
    var x, y: Double
    init(x: Double, y: Double) { (self.x, self.y) = (x, y) }

}

let a = ClassPoint(x: 0, y: 0)
let b = a
a.x = 50
b.x
b.x = 70
a.x

