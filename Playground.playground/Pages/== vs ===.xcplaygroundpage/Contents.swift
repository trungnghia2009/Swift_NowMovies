/*
 
 == operator checks if their instance values are equal, "equal to"
 === operator checks if the references point the same instance, "identical to"
 
 */

import Foundation

class Person {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
}

class Account: Equatable {
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

let person1 = Person(id: 123, name: "David")
let person2 = Person(id: 123, name: "David")

//Class is reference type
let person3 = person1
person3.name = "Doge"
person1.name
person3.name

let account1 = Account(id: 111, name: "Johny")
let account2 = Account(id: 111, name: "Johny")

print("case 1")
if person1 === person2 {
    print("*=== Equal")
} else {
    print("*=== Not equal")
}
print("")

print("case 2")
if person1 === person3 {
    print("*=== Equal")
} else {
    print("*=== Not equal")
}
print("")

print("case 3")
if account1 == account2 {
    print("*== Equal")
} else {
    print("*== Not equal")
}


struct Animal {
    var leg: Int
    var genre: String
}

var dog1 = Animal(leg: 4, genre: "dog")
let dog2 = dog1
dog1.leg = 5
dog1.leg
dog2.leg

