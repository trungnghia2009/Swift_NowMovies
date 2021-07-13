import Foundation

func sum(_ values: [Int]) -> Int {
    var result = 0
    for index in 0..<values.count {
        result += values[index]
    }
    return result
}

func sum(_ values: Int...) -> Int {
    var result = 0
    for value in values {
        result += value
    }
    return result
}

sum([1,2,3,4,5,6,7,8,9,10])
sum(1,2,3,4,5,6,7,8,9,10)
