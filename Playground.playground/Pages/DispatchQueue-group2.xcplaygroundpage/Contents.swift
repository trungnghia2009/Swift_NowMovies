import Foundation

// Synchronous waiting
let dispatchGroup2 = DispatchGroup()
let queue3 = DispatchQueue(label: "queue3", attributes: .concurrent)
let queue4 = DispatchQueue(label: "queue4", attributes: .concurrent)

queue3.async(group: dispatchGroup2) {
    Thread.sleep(forTimeInterval: 2)
    print("Do something in queue 3")
}

queue3.async(group: dispatchGroup2) {
    print("Do another thing in queue 3")
}

queue4.async(group: dispatchGroup2) {
    Thread.sleep(forTimeInterval: 3)
    print("Do something in queue 4")
}

let seconds = 2
if dispatchGroup2.wait(timeout: DispatchTime.now() + .seconds(seconds)) == .timedOut {
    print("The jobs didn't finish in \(seconds) seconds")
}
