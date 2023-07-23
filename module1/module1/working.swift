//
//  working.swift
//  module1
//
//  Created by Asif Habib on 04/07/23.
//

import Foundation
public class Something {
    var someProperty: String
    var someanotherproperty: Int
    public var publicProperty : String
    public init(someProperty: String, someanotherproperty: Int, publicProperty: String) {
        self.someProperty = someProperty
        self.someanotherproperty = someanotherproperty
        self.publicProperty = publicProperty
    }
}

open class Someotherclass{
    var someProperty: String
    var someAnotherProperty: Int
    public var publicProperty : String
    init(someProperty: String, someAnotherProperty: Int, publicProperty : String) {
        self.someProperty = someProperty
        self.someAnotherProperty = someAnotherProperty
        self.publicProperty = publicProperty
    }
}
