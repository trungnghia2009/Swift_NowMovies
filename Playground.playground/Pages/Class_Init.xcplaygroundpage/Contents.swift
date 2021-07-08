// https://viblo.asia/p/tim-hieu-ve-khoi-tao-initialization-trong-swift-part-23-YWOZrDYv5Q0
// Initializer Delegation: Designated Initializer, convenience initializer

import Foundation


class Person {
    var name: String
    var age: Int
    
    // Designated Initializer
    required init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    // Convenience Initializer
    convenience init(name: String, yearOfBirth: Int) {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        self.init(name: name, age: year - yearOfBirth)
    }
}

class Employee: Person {
    var code: String = "abcde"
    
    init(name: String, age: Int, code: String) {
        super.init(name: name, age: age)
        self.code = code
    }
    
    required init(name: String, age: Int) {
        super.init(name: name, age: age)
        self.code = "12345"
    }
}


let person = Employee(name: "Haha", age: 123)
let person2 = Employee(name: "haha", yearOfBirth: 12)

