import Foundation

protocol PersonProtocol {
    var id: Int { get }
    var name: String { get }
    func caculateValue()
}

// Protocal default func, need to implement the func in protocol requirment to
// override it in conformed class or struct
extension PersonProtocol {
    func caculateValue() {
        print("id is \(self.id), name is \(self.name), type is :\(Self.self)")
    }
}

enum PersonAnalytics {
    
    enum AccounRoom: Int, PersonProtocol {
        case feature1 = 1
        case feature2 = 2
        
        var id: Int {
            return self.rawValue
        }
        
        var name: String {
            return "id001"
        }
    }
}

class Person: PersonProtocol {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    //override
    func caculateValue() {
        print("something valuable")
    }
    
}


PersonAnalytics.AccounRoom.feature1.caculateValue()
Person.init(id: 001, name: "Peter").caculateValue()
