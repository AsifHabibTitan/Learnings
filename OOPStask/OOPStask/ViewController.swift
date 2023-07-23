//
//  ViewController.swift
//  OOPStask
//
//  Created by Asif Habib on 04/07/23.
//

import UIKit
import module1

class Student{
    private var name : String
    var rollno : Int
    public var age: Int
    init(name: String, rollno: Int, age: Int){
        self.name = name
        self.rollno = rollno
        self.age = age
    }
    func getMarks() -> Int{
        return 233
    }
    func getMarks(sub: String) -> String {
        return "marks of a subject"
    }
    func getName()-> String {
        return self.name
    }
    func getResult(marks: [Double], maxMarks:Double) -> Bool {
        var sum: Double = 0
        var passed = true
        marks.forEach {
            sum += $0
            if $0 < 33 {
                passed = false
            }
            
        }
        return passed
//        return passed && sum/maxMarks > 0.33
    }
    
}

class ArtsStudent : Student {
    override init(name: String, rollno: Int, age: Int){
        super.init(name: name, rollno: rollno, age: age)
        print("called the child class' constructor")
    }
    override func getMarks() -> Int {
        return 444
    }
    
}

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let st1 = Student(name: "AA", rollno: 11, age: 23)
        let st2 = ArtsStudent(name: "BB", rollno: 22, age: 24)

        print(st1.getMarks())
        print(st2.getMarks())
        print(st2.getMarks(sub: "somestr"))
        print(st1.getMarks(sub: "somestr"))

        //print(st1.name)  // can't access name as it is private
        //print(st2.name)

        print(st1.getName())
        print(st2.getName())

        print(st1.age)
        print(st2.age)
        
        print(st1.getResult(marks: [42, 55, 35, 43, 43, 78], maxMarks: 600))
        // Do any additional setup after loading the view.
        var a = Something(someProperty: "JJ`", someanotherproperty: 343, publicProperty: "sdflkj")
    }


}

