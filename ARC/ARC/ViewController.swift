//
//  ViewController.swift
//  ARC
//
//  Created by Asif Habib on 11/07/23.
//

import UIKit

class Person {
    var name: String
    init(name: String) {
        self.name = name
        print("Person initialized")
    }
    weak var apartment: Apartment?          // if strong reference is created and reference cycle exists memory not deallocated on deallocating references to person and apartment
    deinit {
        print("Person is deallocated")
    }
}
class Apartment {
    var noOfRooms: Int
    init(noOfRooms: Int) {
        self.noOfRooms = noOfRooms
        print("Apartment initialized")
    }
    weak var tenant: Person?
    deinit {
        print("Apartment is deallocated")
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var p1: Person? = Person(name: "Vanjire")
        var a1: Apartment? = Apartment(noOfRooms: 4)

        p1!.apartment = a1
        a1!.tenant = p1

//        p1 = nil
//        a1 = nil
        
        
        
        // Do any additional setup after loading the view.
//        var customer = Customer(name: "SomeName")
//        var card = CreditCard(cardNumber: 23434434344, customer: customer)
//        customer.card = card
//
//        debugPrint(customer.card?.cardNumber)
        
    }


}


class CreditCard {
    var cardNumber : UInt64
    unowned var customer: Customer
    init(cardNumber: UInt64, customer: Customer) {
        print("Initialising card instance")
        self.cardNumber = cardNumber
        self.customer = customer
    }
    deinit{
        print("Deinitialising card instance")
    }
    
}

class Customer {
    var name: String
    var card: CreditCard?
    init(name: String) {
        print("Initialising customer instance")
        self.name = name
      
    }
    deinit{
        print("Deinitialised customer instance")
    }
}
