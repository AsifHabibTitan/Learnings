//
//  ViewController.swift
//  ErrorHandling
//
//  Created by Asif Habib on 12/07/23.
//

import UIKit
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
    
}

//
// throwing functions propagates errors
// do catch block
//  error handling in Swift doesn’t involve unwinding the call stack,
// A throwing function propagates errors that are thrown inside of it to the scope from which it’s called.
//
//

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
            "Candy Bar": Item(price: 12, count: 7),
            "Chips": Item(price: 10, count: 4),
            "Pretzels": Item(price: 7, count: 11)
        ]
    var coinsDeposited = 0
    func vend(itemName: String) throws {
        guard let item = inventory[itemName] else {
            throw VendingMachineError.invalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var updatedItem = item
        updatedItem.count -= 1
        inventory[itemName] = updatedItem
        print("dispensing \(itemName)")
}
    func vendChips() throws {
        try self.vend(itemName: "Chips")
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var vm = VendingMachine()
        vm.coinsDeposited = 14000
        
        defer {
            print("this line should be at last")
        }
        defer {
            print("This should be second last line")
        }
        do {
//            var itm = try vm.vendChips()
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
            try vm.vend(itemName: "Candy Bar")
        }
        catch VendingMachineError.insufficientFunds{
            print("There are insufficient funds")
        } catch VendingMachineError.invalidSelection{
            print("Cannot find that item")
        } catch VendingMachineError.outOfStock{
            print("Seems this product is out of stock")
        } catch{
            print(error)
        }
        		
        // Do any additional setup after loading the view.
    }


}

