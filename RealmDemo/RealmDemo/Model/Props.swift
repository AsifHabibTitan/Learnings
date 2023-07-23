//
//  Props.swift
//  RealmDemo
//
//  Created by Asif Habib on 19/07/23.
//

import Foundation

struct Steps {

    var steps: Int {
        Methods.getRandomNumber(100, 1000)
    }
    var time: TimeInterval
}
struct SpO2 {

    var spo2: Int {
        Methods.getRandomNumber(100, 1000)
    }
    var time: TimeInterval
}

struct HeartRate {
    
    var hr: Int {
        Methods.getRandomNumber(50, 150)
    }
    var time: TimeInterval
}
struct Stress {
    
    var stress: Int {
        Methods.getRandomNumber(100, 1000)
    }
    var time: TimeInterval
}

struct BloodPressure {

    var bp: Int {
        Methods.getRandomNumber(100, 1000)
    }
    var time: TimeInterval
}
