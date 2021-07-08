import Foundation

struct Queue<Element> {
    fileprivate var elements: [Element] = []
    
    mutating func enqueue(newElement: Element) {
        elements.append(newElement)
    }
    
    mutating func dequeue() -> Element? {
        guard !elements.isEmpty else { return nil }
        return elements.remove(at: 0)
    }
}


var q = Queue<String>()

q.enqueue(newElement: "nghia")
q.enqueue(newElement: "ngoc")
q.elements
q.dequeue()
q.elements
