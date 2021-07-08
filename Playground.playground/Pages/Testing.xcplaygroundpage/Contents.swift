import Foundation

class SafeArray<T> {
    let queue = DispatchQueue(label: "thread safe", attributes: .concurrent)
    var elements: [T] = []
    
    func append(_ newElement: T) {
        self.queue.async(flags: .barrier) {
            self.elements.append(newElement)
        }
    }
    
}


let array = SafeArray<Int>()

let queue = DispatchQueue(label: "concurrent", attributes: [.concurrent])
queue.async {
    print("1")
}
queue.async {
    print("2")
}

queue.async {
    print("3")
}
