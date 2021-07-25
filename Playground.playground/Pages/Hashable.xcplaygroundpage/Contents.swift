/*
 
 https://medium0.com/m/global-identity?redirectUrl=https%3A%2F%2Fbetterprogramming.pub%2Fwhat-is-hashable-in-swift-6a51627f904
 
 The documentation lists several Hashable data types, including booleans, integers, and strings, so that they can be used as the keys for a Dictionary and as the elements for a Set.
 
 */

import Foundation

struct Student: Hashable {
    let firstName: String
    let lastName: String
}

var scores = [Student: Int]()
let student1 = Student(firstName: "Nghia", lastName: "Tran")
let student2 = Student(firstName: "Ngoc", lastName: "Tran")
let student3 = Student(firstName: "Ngoan", lastName: "Tran")
let student4 = Student(firstName: "Chinh", lastName: "Le")

scores = [
    student1: 10,
    student2: 9,
    student3: 8,
    student4: 7
]

scores[student3]

struct Dyad: Hashable {
    let leader: Student
    let teamate: Student
}

var dyadScores = [Dyad: Int]()
let group1 = Dyad(leader: student1, teamate: student2)
let group2 = Dyad(leader: student3, teamate: student4)

dyadScores = [
    group1: 9,
    group2: 7
]

dyadScores[group1]
