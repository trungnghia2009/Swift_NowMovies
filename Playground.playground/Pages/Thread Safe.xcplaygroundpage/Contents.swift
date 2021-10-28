/// https://viblo.asia/p/swift-thread-safe-arrays-bWrZnyXQKxw

import UIKit

// Serial Queue
class SafeArray1<T> {
    var array = [T]()
    let serialQueue = DispatchQueue(label: "serialQueue")
    
    var last: T? {
        var result: T?
        self.serialQueue.sync {
            result = self.array.last
        }
        return result
    }
    
    var count: Int {
        var count = 0
        self.serialQueue.sync {
            count = self.array.count
        }
        return count
    }
    
    func append(_ newElement: T) {
        self.serialQueue.sync {
            self.array.append(newElement)
        }
    }
}

// Concurrent queue using barrier
class SafeArray2<T> {
    var array = [T]()
    let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    let semaphore = DispatchSemaphore(value: 1)
    
    var last: T? {
        var result: T?
        self.concurrentQueue.sync {
            result = self.array.last
        }
        return result
    }
    
    var count: Int {
        var count = 0
        self.concurrentQueue.sync {
            count = self.array.count
        }
        return count
    }
    
    func append(_ newElement: T) {
        self.concurrentQueue.async(flags: .barrier) {
            self.array.append(newElement)
        }
    }
}

var safeArray = SafeArray1<Int>()
var array = [Int]()

func doSomething() {
    DispatchQueue.concurrentPerform(iterations: 10) { index in
        safeArray.append(index)
    }
    print(safeArray.count)
    print(safeArray.array)
    let a = safeArray.array.sorted { num1, num2 in
        num1 < num2
    }
    print(a)
}

doSomething()
