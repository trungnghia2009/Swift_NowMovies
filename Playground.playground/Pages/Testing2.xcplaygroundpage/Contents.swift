import UIKit

class Singleton {
    var dogeCoin = 0
    var pond = 0
    
    private init() {
        dogeCoin = 1
        pond = 2
    }
    
    static var shared: Singleton?
    static var value1 = 0
    static let value2 = 10
    
    static func initialize() {
        guard shared == nil else {
            return
        }
        shared = Singleton()
    }
    
    static func destroy() {
        guard shared != nil else {
            return
        }
        shared = nil
        value1 = 0
    }
}


Singleton.initialize()
Singleton.shared?.pond
Singleton.destroy()
Singleton.initialize()
Singleton.shared?.pond = 5
Singleton.shared?.pond
Singleton.destroy()
Singleton.shared?.pond
