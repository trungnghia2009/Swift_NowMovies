/*
 https://uynguyen.github.io/2018/01/04/Grand-Central-Dispatch-in-Swift/
 
 The word Deadlock refers to a situation in which a set of different threads sharing the same resource are waiting for each other release the resource to finish its tasks.
 
 */

import Foundation

func deadLock1() {
    let bookingCounterQueue = DispatchQueue(label: "bookingCounter")
    let driverQueue = DispatchQueue(label: "driver")

    driverQueue.sync {
        print("Give me a ticket")

        bookingCounterQueue.sync {
            print("Which movie")
        }

        driverQueue.sync {
            print("I'll ask the boss once you give me the tickets...")
        }
    }
}


func deadLock2() {
    let myQueue = DispatchQueue(label: "myLabel")
    myQueue.async {
        myQueue.sync {
            print("Inner block called")
        }
        print("Outer block called")

    }
}

//let serialQueue = DispatchQueue(label: "serialQueue")
//serialQueue.async {
//    print("serial-task1")
//}
//serialQueue.async {
//    print("serial-task2")
//}
//serialQueue.async {
//    print("serial-task3")
//}
//serialQueue.async {
//    print("serial-task4")
//}


let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
let array = [1,2,3,4,5,6]
let randomize = array.shuffled()
let result = randomize.prefix(1)
