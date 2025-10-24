//
//  Props.swift
//  RealmDemo
//
//  Created by Asif Habib on 19/07/23.
//

import Foundation
import RealmSwift

class Steps : Object {
    @Persisted var steps: Int = 0
    @Persisted var time: TimeInterval = 0.0
}

class SpO2 : Object {
    @Persisted var spo2: Int = 0
    @Persisted var time: TimeInterval = 0.0
}

class HeartRate : Object {
    @Persisted var heartRate: Int = 0
    @Persisted var time: TimeInterval = 0.0
}

class Stress : Object {
    @Persisted var stress: Int = 0
    @Persisted var time: TimeInterval = 0.0
}

class BloodPressure : Object {
//    @Persisted var bp: Int = 0
    @Persisted var systolic : Int = 0
    @Persisted var diastolic: Int = 0
    @Persisted var time: TimeInterval = 0.0
}

class Category : Object {
    @Persisted var value: Int = 0
    @Persisted var time: TimeInterval = 0.0
}

class Data: Object {
    @Persisted var hrData = List<HeartRate>()
    @Persisted var stressData = List<Stress>()
    @Persisted var spo2Data = List<SpO2>()
    @Persisted var bpData = List<BloodPressure>()
    @Persisted var stepsData = List<Steps>()
}
