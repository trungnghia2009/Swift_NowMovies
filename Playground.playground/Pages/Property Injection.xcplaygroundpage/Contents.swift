/*
 
 When to use: dependencies need to be changed later or you do not directly initialize the object. View controllers and NSManagedObject are examples of the latter.
 
 ✓ Pros:
 - Allows to set dependencies later.
 - Provides readable way of constructing objects with many dependencies.
 
 ✕ Cons:
 - Client might be left in inconsistent state if some dependencies are missing.
 - Leaks encapsulation.
 - Imposes the use of optional or force unwrapped properties.

*/

import UIKit
import XCTest

protocol Dependency {
    func foo()
}

class DependencyImplementation: Dependency {
    func foo() {
        print("Action 1")
    }
}

class Mock: Dependency {
    func foo() {
        print("Action 2")
    }
}

class Client {
    var dependency: Dependency!
    
    func doSomething() {
        dependency.foo()
    }
}

let client = Client()
client.dependency = DependencyImplementation()
client.doSomething()

let sut = Client()
sut.dependency = Mock()
sut.doSomething()
