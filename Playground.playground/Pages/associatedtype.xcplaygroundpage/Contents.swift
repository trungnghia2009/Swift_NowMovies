/// https://www.hackingwithswift.com/example-code/language/what-is-a-protocol-associated-type
import Foundation

protocol ItemSorting {
    associatedtype DataType: Hashable // add type constrain
    
    var items: [DataType] { get set}
    mutating func add(item: DataType)
}

extension ItemSorting {
    mutating func add(item: DataType) {
        items.append(item)
    }
}

struct NameDatabase: ItemSorting {
    var items = [String]()
}

var names = NameDatabase()
names.add(item: "James")
names.add(item: "Jess")
names.items
