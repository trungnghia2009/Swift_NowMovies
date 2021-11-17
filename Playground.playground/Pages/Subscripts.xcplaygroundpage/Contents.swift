///https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html

// Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence

import Foundation

struct TimesTable {
    let multipler: Int
    
    subscript(index: Int) -> Int {
        return multipler * index
    }
}

let threeTimesTable = TimesTable(multipler: 3)
print("six times three is \(threeTimesTable[6])")

struct Grip {
    let grip = [
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 10, 11, 12],
        [13, 14, 15, 16],
        [5, 6, 7, 8]
    ]
    
    subscript(row: Int, col: Int) -> Int? {
        let maxCol = grip.first?.count ?? 0
        guard col < maxCol, col >= 0 else { return nil }
        
        let maxRow = grip.count
        guard row < maxRow, row >= 0 else { return nil }
        
        let number = grip[row][col]
        return number
    }
}

let grip = Grip()
print("Grip value: \(grip[2, 2] ?? -1)")
print("Grip value: \(grip[3, 3] ?? -1)")
