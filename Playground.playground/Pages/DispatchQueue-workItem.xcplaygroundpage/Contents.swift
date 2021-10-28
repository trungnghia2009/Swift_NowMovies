import UIKit

let label = "queue1"
let queue1 = DispatchQueue(label: label,
                          qos: .userInitiated,
                          attributes: .concurrent)

let queue2 = DispatchQueue(label: "queue2", attributes: .concurrent)

let workItem1 = DispatchWorkItem {
    Thread.sleep(forTimeInterval: 2)
    print("The block1 of code starting...")
    Thread.sleep(forTimeInterval: 2)
    print("The block1 of code run...")
}

let workItem2 = DispatchWorkItem {
    print("The block2 of code starting...")
}

workItem1.notify(queue: queue2, execute: workItem2)

queue1.async(execute: workItem1)
