//
//  classes.swift
//  FrameworkForOops
//
//  Created by Asif Habib on 16/06/23.
//

import Foundation

class Student {
    public var age = 22
    private var name = "Random"
    var phone = "7748477484"
    fileprivate privateToFile = "secret"
    
    public getStudent() {
        return "Student is \(self.name) with age \(self.age)"
    }
}
