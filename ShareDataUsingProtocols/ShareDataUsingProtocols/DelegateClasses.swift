//
//  DelegateClasses.swift
//  ShareDataUsingProtocols
//
//  Created by Asif Habib on 13/07/23.
//

import Foundation

class TitanWatch {
    static var current: VendorDelegate = Linwear()
}

protocol VendorDelegate {
    func getSteps() -> Int
    func getSleepData() -> Int
    func getHeartRate() -> Int
    func getSpO2() -> Int
    func getTemprature() -> Int
}

class Linwear: VendorDelegate {

    func getSteps() -> Int {
        return 23
    }
    func getSpO2() -> Int {
        return 44
    }
    func getTemprature() -> Int {
        return 89
    }
    func getHeartRate() -> Int {
        99
    }
    func getSleepData() -> Int {
        44
    }
}

class Ido: VendorDelegate {

    func getSteps() -> Int {
        return 345
    }
    func getSpO2() -> Int {
        return 444
    }
    func getTemprature() -> Int {
        return 443
    }
    func getHeartRate() -> Int {
        234
    }
    func getSleepData() -> Int {
        235
    }
}

class Yawell: VendorDelegate {

    func getSteps() -> Int {
        return 1
    }
    func getSpO2() -> Int {
        return 2
    }
    func getTemprature() -> Int {
        return 3
    }
    func getHeartRate() -> Int {
        4
    }
    func getSleepData() -> Int {
        5
    }
}
