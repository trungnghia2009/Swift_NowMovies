/// https://www.raywenderlich.com/966538-arc-and-memory-management-in-swift
import Foundation


// 1. Strong reference between 2 classes

class User {
    let name: String
    private(set) var phones: [Phone] = []
    var subscriptions: [CarrierSubscription] = []
    
    func add(phone: Phone) {
        phones.append(phone)
        phone.owner = self
    }
    
    init(name: String) {
        self.name = name
        print("User \(name) was initialized")
    }
    
    deinit {
        print("Deallocating user named: \(name)")
    }
}

class Phone {
    let model: String
    weak var owner: User?  // Have to define "weak" to avoid reference cycle
    var carrierSubscription: CarrierSubscription?
    
    func provision(carrierSubscription: CarrierSubscription) {
        self.carrierSubscription = carrierSubscription
    }
    
    func decomission() {
        carrierSubscription = nil
    }
    
    init(model: String) {
        self.model = model
        print("Phone \(model) was initialized")
    }
    
    deinit {
        print("Deallocating phone named: \(model)")
    }
}

class CarrierSubscription {
    let name: String
    let countryCode: String
    let number: String
    unowned let user: User // Have to define "unowned" to avoid reference cycle
    
    lazy var completePhoneNumber: () -> String = { [unowned self] in
        self.countryCode + " " + self.number
    }
    
    init(name: String, countryCode: String, number: String, user: User) {
        self.name = name
        self.countryCode = countryCode
        self.number = number
        self.user = user
        user.subscriptions.append(self)
        print("CarrierSubscription \(name) is initialized")
    }
    
    deinit {
        print("Deallocating CarrierSubscription named: \(name)")
    }
}

// For testing
class Testing {
    func testStrong() {
        let user = User(name: "peter")
        let phone = Phone(model: "iPhone 13 pro max")
        let carrier = CarrierSubscription(name: "mobiphone",
                                          countryCode: "VN",
                                          number: "0938477490",
                                          user: user)
        user.add(phone: phone)
        phone.provision(carrierSubscription: carrier)
        print("Phone number is \(carrier.completePhoneNumber())")
    }
}

let test1 = Testing()
test1.testStrong()
