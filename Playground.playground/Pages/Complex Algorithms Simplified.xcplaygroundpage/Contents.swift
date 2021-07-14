//https://swiftsenpai.com/swift/5-complex-algorithms-simplified/
// higher-order functions: filter, map, reduce

import Foundation

// The model object of upcoming examples
let students = [
    Student(id: "001", name: "Jessica", gender: .female, age: 20),
    Student(id: "002", name: "James", gender: .male, age: 25),
    Student(id: "003", name: "Mary", gender: .female, age: 19),
    Student(id: "004", name: "Edwin", gender: .male, age: 27),
    Student(id: "005", name: "Stacy", gender: .female, age: 18),
    Student(id: "006", name: "Emma", gender: .female, age: 22),
]

enum Gender {
    case male
    case female
}

struct Student {
    let id: String
    let name: String
    let gender: Gender
    let age: Int
}

// Grouping Array Elements by Criteria
let groupByFirstLetter = Dictionary(grouping: students, by: { $0.name.first } )

groupByFirstLetter.forEach { (key: String.Element?, value: [Student]) in
    guard let key = key else { return }
    print(key, value)
}

// Counting Occurrence of Array Elements based on certain criteria
// filter has O(n) time complexity
let famaleAmount = students.filter { $0.gender == .female }.count
famaleAmount
let maleAmount = students.filter { $0.gender == .male }.count
maleAmount

// Getting the Sum of an Array
var sum = students.reduce(0) { result, student in
    return result + student.age
}
sum = students.reduce(0, { $0 + $1.age })
sum
let sum1 = [2, 3, 4].reduce(0, +)
let sum2 = [2.6, 2.3, 4].reduce(0, +)
let sum3 = ["a", "b", "c"].reduce("", +)

// Accessing Array Elements by ID
let studentsTuple = students.map { ($0.id, $0) }
let studentsDictionary = Dictionary(uniqueKeysWithValues: studentsTuple)
if let emma = studentsDictionary["006"] {
    print(emma)
}
/// O(n + 1)

// Getting a Number of Random Elements From An Array
let randomized = students.shuffled()
let selected = randomized.prefix(3)
