//
//  Methods.swift
//  RealmDemo
//
//  Created by Asif Habib on 19/07/23.
//

import Foundation

class Methods {
    static func getRandomNumber(_ start:Int, _ end: Int) -> Int{
        Int.random(in: start...end)
    }
}
