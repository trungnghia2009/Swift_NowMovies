import Foundation
//https://www.raywenderlich.com/3535703-swift-generics-tutorial-getting-started

// Queue
struct Queue<Element: Comparable> {
    private var elements = [Element]()
    
    // take value from the front
    mutating func dequeue() -> Element? {
        guard !elements.isEmpty else { return nil }
        return elements.remove(at: 0)
    }
    
    // add new value to the end
    mutating func enqueue(newElement: Element) {
        elements.append(newElement)
    }
    
    func showElements() -> [Element] {
        return elements
    }
}

var q = Queue<Int>()
q.enqueue(newElement: 1)
q.enqueue(newElement: 2)

q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()


// Function
func pairs<Key, Value>(from dictionary: [Key: Value]) -> [(Key, Value)] {
    return Array(dictionary)
}

let somePairs = pairs(from: ["minimun": 199, "maximum": 299])
print(somePairs)
let morePairs = pairs(from: [1: "Swift", 2: "Generic", 3: "Rule"])
print(morePairs)


// Constraining a Generic Type
// Sort an array and find the middle value
func mid<T: Comparable>(array: [T]) -> T? {
    guard !array.isEmpty else { return nil }
    return array.sorted()[(array.count - 1) / 2]
}

let number = mid(array: [1,3,4,5,6,5,7,0])


// Cleaning up the Add functions
protocol Summable {
    static func +(lhs: Self, rhs: Self) -> Self
}
extension Int: Summable {}
extension Double: Summable {}
extension String: Summable {}

func add<T: Summable>(x: T, y: T) -> T {
    return x + y
}

let addIntSum = add(x: 1, y: 2)
let addDoubleSum = add(x: 1.0, y: 3.0)
let addString = add(x: "Nghia", y: " is handsome")

// Extending a Generic Type
extension Queue {
    func peek() -> Element? {
        return elements.first
    }
    
    // Check all elements of the queue are equal
    func isHomegeneous() -> Bool {
        guard let first = elements.first else { return true }
        return !elements.contains { $0 != first }
    }
}

q.enqueue(newElement: 5)
q.enqueue(newElement: 3)
q.peek()


// Enumeration with Associated values
enum Reward<T> {
    case treasureChest(T)
    case medal
    
    var message: String {
        switch self {
        case .treasureChest(let treasure):
            return "You got a chest filled with \(treasure)."
        case .medal:
            return "Stand proud, you earned a medal!"
        }
    }
}

let message = Reward.treasureChest(Queue<Int>().showElements()).message
print(message)
