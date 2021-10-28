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
