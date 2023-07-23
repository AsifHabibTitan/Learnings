//
//  ViewController.swift
//  TrainingOnClasses
//
//  Created by Asif Habib on 27/06/23.
//

import UIKit
class Person {
    static var age = 22 // memory get allocated at the time of compilation
    var gender: String
    var height: Int
    init( gender: String, height: Int){
    
        self.gender = gender
        self.height = height
    }
}
struct Payment {
    var amount: Float
    var commision: Float
    var profit: Float {
        return amount + commision
    }
}
class StepCounter {
    var totalSteps: Int = 0{
        willSet(newValue) {
            print("setting new value for steps \(newValue)")
        }
        didSet(dd){
            if totalSteps > dd {
                print("Added \(totalSteps - dd) steps")
            }
        }
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        var p1 = Person(age: 3, gender: "M", height: 44)
//        var p2 = p1
//        debugPrint(Unmanaged.passUnretained(p1).toOpaque())
//        debugPrint(Unmanaged.passUnretained(p2).toOpaque())
        var profit = Payment(amount: 23, commision: 44)
        debugPrint(profit.profit)
        // Do any additional setup after loading the view.
        var s = StepCounter()
        s.totalSteps = 499
        s.totalSteps = 343
        s.totalSteps = 713
        
        var personWithStaticVar = Person(gender: "M", height: 330)
        debugPrint(Person.age, personWithStaticVar.gender)
    }


}

