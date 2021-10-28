// solve swap 2 numbers problem

import Foundation

// 1
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
var num1 = 5
var num2 = 6

var point1 = Point<Int>(a: num1, b: num2)
point1.swap()
point1.a
point1.b

var point2 = Point<String>(a: "doge", b: "cate")
point2.swap()
point2.a
point2.b

// 2
func swapAnything<T: Hashable>(_ tuple: (T, T) ) -> (T, T) {
    return (tuple.1, tuple.0)
}

let swapThing = swapAnything(("a", "b"))
swapThing.0
swapThing.1


// 3
func swapTwoValue<T>(_ a: inout T, _ b: inout T) {
    let temp = (a, b)
    a = temp.1
    b = temp.0
}

var firstValue = "Host"
var secondValue = "Client"

swapTwoValue(&firstValue, &secondValue)

firstValue
secondValue
