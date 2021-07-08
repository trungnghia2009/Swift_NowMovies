/*
 When to use: whenever possible. Fits best when the number of dependencies is low or the object needs to be immutable.
 
 ✓ Pros:
 - Provides best encapsulation.
 - Ensures that client object is always in a valid state.
 
 ✕ Cons:
 - Dependencies cannot be changed later.
 - Becomes cumbersome with more than 3 dependencies. Consider property injection in this case.
 
*/

import UIKit

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
    let dependency: Dependency
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    func doSomething() {
        dependency.foo()
    }
}

let client = Client(dependency: DependencyImplementation())
client.doSomething()

let sut = Client(dependency: Mock())
sut.doSomething()
