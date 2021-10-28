// https://viblo.asia/p/tim-hieu-ve-khoi-tao-initialization-trong-swift-part-23-YWOZrDYv5Q0
/*
 Initializer
    1. Designated Initializer
    2. Required Initializer (require in subclass)
    3. convenience initializer (init in init)
    4. Override Initializer
    5. Optional Initializer
 */

import Foundation


class Person {
    var name: String
    var age: Int
    
    // Designated Initializer
    init(name: String) {
        self.name = name
        self.age = 31
    }
    
    // Required Initializer
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
    var code: String
    
    // Designated Initializer
    init(name: String, age: Int, code: String) {
        self.code = code
        super.init(name: name, age: age)
    }
    
    // Required Initializer
    required init(name: String, age: Int) {
        self.code = "xxss22"
        super.init(name: name, age: age)
    }
    
    // Override Initializer
    override init(name: String) {
        self.code = "32"
        super.init(name: name)
    }
    
    // Optional Initalizer
    init?(yourMotherName: String, yourName: String) {
        if yourMotherName.isEmpty { return nil }
        self.code = "xxyy"
        super.init(name: yourName)
    }
}

let employee1 = Employee(name: "Nghia", age: 31)
employee1.code
employee1.name

let employee2 = Employee(yourMotherName: "", yourName: "Nghia")
employee2?.code
employee2?.name
