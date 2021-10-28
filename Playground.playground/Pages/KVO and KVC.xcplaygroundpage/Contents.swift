/// https://anuragajwani.medium.com/introduction-to-kvo-and-kvc-in-swift-dceadfcf1b28

// You can interact with a property through a stringly typed key instead of your usual dot syntax which is checked at compile time.

import UIKit

protocol PokemonInterface: AnyObject {
    var name: String { get }
}

class ViewController: UIViewController {
    
}

// KVC & KVO
class Pokemon: NSObject {
    @objc dynamic var name: String
    
    init(name: String) {
        self.name = name
    }
}

// Normal
class Person {
    var name: String {
        willSet {
            print("new value: \(newValue)")
        }
        
        didSet {
            print("old name: \(oldValue)")
        }
    }
    
    init(name: String) {
        self.name = name
    }
}

// 1
let myFirstPokemon = Pokemon(name: "Charmander")

// KVC
let pokemonName = myFirstPokemon.value(forKey: "name")
myFirstPokemon.setValue("Charmeleon", forKey: "name")

// KVO
myFirstPokemon.observe(\.name, options: [.old, .new]) { (pokemon, value) in
    print("old name \(value.oldValue ?? "")")
    print("new name \(value.newValue ?? "")")
}
myFirstPokemon.name = "Charmeleon"

print("")


// 2
let person = Person(name: "nghia")
person.name = "ngoc"
