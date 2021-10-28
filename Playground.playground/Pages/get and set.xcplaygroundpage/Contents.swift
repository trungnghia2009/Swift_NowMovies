// https://chetan-aggarwal.medium.com/swift-protocols-properties-distinction-get-get-set-32a34a7f16e9
import Foundation

protocol FullyNamed {
    var fullName: String { get }
}

// Gettable — Private Set
struct Detective: FullyNamed {
    private(set) var fullName: String
    init(fullName: String) {
        self.fullName = fullName
    }
    
    mutating func renameWith(fullName: String) {
        self.fullName = fullName
    }
}

var spiderman = Detective(fullName: "Peter Baker")
spiderman.fullName
spiderman.renameWith(fullName: "Tony")
spiderman.fullName

// Gettlable & Settable - Computed Property
struct Detective1: FullyNamed {
    fileprivate var name: String
    var fullName: String {
        get {
            return name
        }
        set {
            name = newValue + " new" // activate to set value
        }
    }
}

var Payne = Detective1(name: "Payne")
Payne.fullName
Payne.fullName = "Max Payne"
Payne.fullName


// Type casting with protocol
protocol FullyNamed1 {
    var firstName: String { get }
    var lastName: String { get set }
}
struct SuperHero: FullyNamed1 {
    var firstName = "Super"
    var lastName = "Man"
}

var hero: FullyNamed1 = SuperHero()
//hero.firstName = "Bat" ->  cannot assign to property: ‘firstName’ is a get-only
hero.lastName = "Girl"
