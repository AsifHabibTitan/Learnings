//
//  Person.swift
//  CollectionViewTask2
//
//  Created by Asif Habib on 18/07/23.
//

import Foundation
import RealmSwift
class Person: Object {
    var name: String
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    
}
