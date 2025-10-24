//
//  Person.swift
//  RealmDemo
//
//  Created by Asif Habib on 19/07/23.
//

import Foundation
import RealmSwift

class Person: Object {
    @Persisted var name : String = ""
    @Persisted var age : Int = 44
    @Persisted var hr: Int = 0
    @Persisted var steps: Int = 0
    @Persisted var spo2: Int = 0
    @Persisted var bp: Int = 0
    @Persisted var stress: Int = 0
    var time: TimeInterval = .greatestFiniteMagnitude
    
    convenience init(name: String, age: Int) {
        self.init()
        self.name = name
        self.age = age
        
        self.steps = Methods.getRandomNumber(100, 1000)
        self.spo2 = Methods.getRandomNumber(80, 100)
        self.bp = Methods.getRandomNumber(80, 120)
        self.stress = Methods.getRandomNumber(40, 100)
        
    }
    
    func generateRandomData() {
        
    }
}
//class Person2: Object {
//    @Persisted var name : String = ""
//    @Persisted var age : Int = 44
//    @Persisted var hr = [HeartRate]()
//    @Persisted var steps = [Steps]()
//    @Persisted var spo2 = [SpO2]()
//    @Persisted var bp = [BloodPressure]()
//    @Persisted var stress = [Stress]()
//    
//    var time: TimeInterval = .greatestFiniteMagnitude
//    
//    convenience init(name: String, age: Int) {
//        self.init()
//        self.name = name
//        self.age = age
//        
////        self.steps = Methods.getRandomNumber(100, 1000)
////        self.spo2 = Methods.getRandomNumber(80, 100)
////        self.bp = Methods.getRandomNumber(80, 120)
////        self.stress = Methods.getRandomNumber(40, 100)
//        
//    }
//    
//    func generateRandomData() {
//        
//    }
//}
