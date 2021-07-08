// https://viblo.asia/p/tim-hieu-ve-khoi-tao-initialization-trong-swift-part-13-XL6lAYVplek
// Extension init
// Initializer Delegation
// Handle exception (optional init, throw error)

import Foundation

enum InvalidPersonError: Error {
    case EmptyName
    case InvalidAge
}

struct Person {
    let name: String
    let age: Int
    var numberOfChild: Int?
}

extension Person {
    init(name: String, age: Int) throws {
        if name.isEmpty {
            throw InvalidPersonError.EmptyName
        }
        
        if age < 0 {
            throw InvalidPersonError.InvalidAge
        }
        
        self.name = name
        self.age = age
        self.numberOfChild = 2
    }
}
let person1 = try! Person(name: "Nghia", age: 20)

do {
    let person2 = try Person(name: "Hali", age: -20)
    person2.age
    person2.name
} catch let error {
    switch error {
    case InvalidPersonError.EmptyName:
        print("exit code 1")
    case InvalidPersonError.InvalidAge:
        print("exit code 2")
    default:
        print("unknown error")
    }
}

