/*
 https://viblo.asia/p/su-khac-biet-giua-class-va-static-trong-swift-la-gi-yMnKMbpQZ7P
 
 static: This is helpful for organizing your data meaningfully by storing shared data.
 class: The same as static, but allow overrive and only use computed property (not store data)
 
 */

import Foundation

class SuperCar {
    static let country = "Japan" // not allow to override
    class var color: String { return "White" }  // computed property
    let name, type: String
    
    init(name: String, type: String) {
        self.name = name
        self.type = type
    }
    
    static func caculateSome() {
        print("caculateSome")
    }
    
    class func writeSome() {
        print("writeSome")
    }
}

class Car: SuperCar {
    override class var color: String {
        return "Black"
    }
    
    override class func writeSome() {
        print("write cate..")
    }
    
}

SuperCar.country
SuperCar.color
SuperCar.caculateSome()
SuperCar.writeSome()

Car.country
Car.color
Car.caculateSome()
Car.writeSome()
