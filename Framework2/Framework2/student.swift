//
//  student.swift
//  Framework2
//
//  Created by Asif Habib on 16/06/23.
//

import Foundation

public class Student {
    static var variable = 333
    public var age = 22
    private var name = "Random"
    var phone = "4474737738"
    fileprivate var privateProp = "secret"
    
    public func getStudent() -> String {
        return "The student is \(self.name) with age \(self.age)"
    }
}
