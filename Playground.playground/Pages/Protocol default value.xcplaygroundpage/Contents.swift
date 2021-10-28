import UIKit

protocol Animal {
    static var leg: Int { get }
    func calculateSpeed(genre: String) -> Int
}

// Assign default value for leg, using extension for protocol
extension Animal {
    static var leg: Int {
        return 2
    }
}

class Dog: Animal {
    func calculateSpeed(genre: String) -> Int {
        return 100
    }
}

Dog.leg
let dog = Dog()
dog.calculateSpeed(genre: "Something")

// Conform "AnyObject" to limit protocol only use for classes
protocol TableCellProtocol: AnyObject {
    func didTapFavoriteBtn()
}

class Game: TableCellProtocol {
    func didTapFavoriteBtn() {
        print("ahaha")
    }
}

// Limiting the conformance to a protocol
protocol SomethingForUIView where Self: UIViewController {
    func showLocalizedAlert(text: String)
}

class RoomViewController: UIViewController, SomethingForUIView {
    func showLocalizedAlert(text: String) {
    }
}
