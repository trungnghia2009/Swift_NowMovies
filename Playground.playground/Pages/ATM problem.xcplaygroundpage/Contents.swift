//https://freesuraj.github.io/2019/03/26/RaceConditions/

/*
 
Solutions to avoid race condition:
 1. Serial queue
 2. NSLock
 3. Barrier
 4. Semaphore

 
let’s answer what’s lock, mutex and semaphore?

- A lock is a way to allow only one thread to enter a piece of code. A lock is not shared with any other processes that the thread shares resources with.
- A mutex is similar to lock, i.e. it is a lock to a shared resource, like database table, or criticial piece of code, but it can be shared across multiple processes.
- A semaphore is similar to mutex, but it can allow x number of threads to simultaneously access the resource.

 */

import Foundation

class Account {
    var name: String
    var balance: Int = 0
    
    init(name: String) {
        self.name = name
    }
}

struct ATM {
    let tag: String
    init(_ tag: String) {
        self.tag = tag
    }
    
    static let serialQueue = DispatchQueue(label: "Serial Queue")
    static let concurrentQueue = DispatchQueue(label: "ConcurrentQueue", qos: .utility, attributes: .concurrent)
    static let lock = NSLock()
    static let semaphore = DispatchSemaphore(value: 1)
    
    func withdraw(_ account: Account, _ amount: Int) {
        
        ///Barrier
//        ATM.concurrentQueue.async (flags: .barrier) {
//            self.withdrawRaw(account, amount)
//        }
        
        ///Serial queue
//        ATM.serialQueue.async {
//            self.withdrawRaw(account, amount)
//        }
        
        ///Semaphore
//        ATM.semaphore.wait()
//        withdrawRaw(account, amount)
//        ATM.semaphore.signal()
        
        ///NSlock
        ATM.lock.lock()
        withdrawRaw(account, amount)
        ATM.lock.unlock()
    }
    
    private func withdrawRaw(_ account: Account, _ amount: Int) {
        print("Request to withdraw \(amount) from account with balance \(account.balance)")
        guard account.balance >= amount else {
            print("balanceNotEnough")
            return
        }
        print("balance \(account.balance) enough ✅ to withdraw \(amount)" )
        // Sleeping for some random time, simulating a long process
        Thread.sleep(forTimeInterval: Double.random(in: 0...2))
        account.balance -= amount
        print("withdrawn: \(amount), remaining balance: \(account.balance)")
        print("")
    }
}


//--------Testing area---------

let user = Account(name: "Nghia")
user.balance = 1000

let atm1 = ATM("a")
let atm2 = ATM("b")
let atm3 = ATM("c")

///Barrier, Serial queue
//atm1.withdraw(user, 600)
//atm2.withdraw(user, 700)


///Semaphore, NSlock
ATM.concurrentQueue.async {
    atm1.withdraw(user, 600)
}
ATM.concurrentQueue.async {
    atm2.withdraw(user, 700)
}
