import UIKit

class Phone {
    var name : String
    
    init( name:String ){
        self.name = name
    }
    func describe() {
        print("I am phone with name: \(self.name)")
    }
}

class CalculatorPhone : Phone {
    var scientific: Bool
    init(name: String, scientific: Bool) {
        self.scientific = scientific
        super.init(name: name)
        
    }
    
    override func describe() {
        print("I am phone with name: \(self.name). am I scientific ? \(scientific)")
    }
}

class SmartPhone: Phone {
    var phoneNumber: Int
    init(name: String, phoneNumber: Int) {
        self.phoneNumber = phoneNumber
        super.init(name: name)
    }
    override func describe() {
        print("I am phone with name: \(self.name) using phonenumber: \(phoneNumber)")
    }
    func call() {
        print("Calling \(self.phoneNumber)")
    }
}

let smartphone = SmartPhone(name: "moto", phoneNumber: 8898232333)
let calcPhone = CalculatorPhone(name: "casio", scientific: false)
let phone = Phone(name: "nokia")

let phones : [Phone] = [smartphone,calcPhone,phone]

phones.forEach { phone in
    print(phone)
    phone.describe() // polymorphism
    if let phone = phone as? SmartPhone {
        phone.call()
    }
    
}



// Automatic memberwise initialization
struct Person {
    var name: String?
    var age: Int?
}

class PersonClass {
    var name: String?
    var age: Int?
}

let p1 = Person(name:"", age: 3)

