import Foundation
/*
 Sometimes, instead of just tossing a job into a queue, you need to process a group of jobs. They don’t all have to run at the same time, but you need to know when they have all completed. Apple provides Dispatch Groups for this exact scenario.
 */

// Want to track the completion of a group of tasks
let dispatchGroup1 = DispatchGroup()
let queue1 = DispatchQueue(label: "queue1", attributes: .concurrent)
let queue2 = DispatchQueue(label: "queue2", attributes: .concurrent)

queue1.async(group: dispatchGroup1) {
    Thread.sleep(forTimeInterval: 2)
    print("Do something in queue 1")
}

queue1.async(group: dispatchGroup1) {
    print("Do another thing in queue 1")
}

queue2.async(group: dispatchGroup1) {
    Thread.sleep(forTimeInterval: 3)
    print("Do something in queue 2")
}

// The notification is itself asynchronous
dispatchGroup1.notify(queue: DispatchQueue.main) {
    print("All tasks have completed")
}
