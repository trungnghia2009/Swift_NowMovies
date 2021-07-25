// solve swap 2 numbers problem

import Foundation

struct Point<T> {
    var a, b: T
}

extension Point {
    private func swapped() -> Self {
        Point(a: b, b: a)
    }
    
    mutating func swap() {
        self = swapped()
    }
}

var point1 = Point<Double>(a: 5, b: 6)
point1.swap()
point1.a
point1.b

var point2 = Point<String>(a: "doge", b: "cate")
point2.swap()
point2.a
point2.b

func swapTwo<T>(_ tuple: (T, T) ) -> (T, T) {
    return (tuple.1, tuple.0)
}

swapTwo(("a", "b"))
swapTwo((1, 2))
