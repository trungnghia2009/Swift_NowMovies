// https://viblo.asia/p/tim-hieu-ve-khoi-tao-initialization-trong-swift-part-13-XL6lAYVplek
// Extension init
// Initializer Delegation
// Handle error (optional init, throw error)

import Foundation

// Initializer Delegation
struct Person {
    let name: String
    let age: Int
    var numberOfChild: Int
}

extension Person {
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        self.numberOfChild = 2
    }
    
    // Initializer Delegation (init in init)
    init(name: String, yearOfBirth: Int) {
        let age = 2021 - yearOfBirth
        self.init(name: name, age: age)
    }
}

let peter = Person(name: "Peter", yearOfBirth: 1990)
peter.age
peter.name
peter.numberOfChild

// Optional init
extension Person {
    init?(yourName: String, age: Int) {
        if age < 0 { return nil }
        self.name = yourName
        self.age = age
        self.numberOfChild = 2
    }
}

let tom = Person(yourName: "Tom", age: 9)

// Throw exception
struct User {
    let name: String
    let age: Int
    let numberOfChild: Int
}

enum InvalidUserError: Error {
    case EmptyName
    case InvalidAge
}

extension User {
    init(name: String, age: Int) throws {
        if name.isEmpty {
            throw InvalidUserError.EmptyName
        }
        
        if age < 0 {
            throw InvalidUserError.InvalidAge
        }
        
        self.name = name
        self.age = age
        self.numberOfChild = 2
    }
}

do {
    let marry = try User(name: "", age: 2)
    print("success \(marry)")
} catch InvalidUserError.EmptyName {
    print("name cannot empty")
} catch InvalidUserError.InvalidAge {
    print("age cannot be less than 5")
}


