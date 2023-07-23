//
//  ViewController.swift
//  protocols
//
//  Created by Asif Habib on 19/06/23.
//

import UIKit
protocol Person {
    var name : String { get set }
    var age : Int { get }
//    func setName( _ name: String )
}

extension Person {
    func greet() {
        print("extended protocol")
    }
}

class Stud : Person {
//    func setName(_ name: String) {
//        print("setting name")
//    }
    var str = "newString"
    var age = 43
    
    var name: String {
        get {
            return "some name \(str)"
        }
        set {
            str = newValue
        }
    }
    
//    init(_ name: String) {
//        self.name = name
//    }
//    func setName( _ name : String ) {
//        self.name = name
//    }
}


protocol Bird {
  var name: String { get }
  var canFly: Bool { get }
}

extension Bird {
  // Flyable birds can fly!
  var canFly: Bool { self is Flyable }
}

protocol Flyable {
  var airspeedVelocity: Double { get }
}

struct FlappyBird: Bird, Flyable {
  let name: String
  let flappyAmplitude: Double
  let flappyFrequency: Double
  let canFly = true

  var airspeedVelocity: Double {
    3 * flappyFrequency * flappyAmplitude
  }
}

struct Penguin: Bird, Flyable{
    var airspeedVelocity: Double
    
  let name: String
}

struct SwiftBird: Bird, Flyable {
  var name: String { "Swift \(version)" }
  let version: Double
  private var speedFactor = 1000.0
  
  init(version: Double) {
    self.version = version
  }

  // Swift is FASTER with each version!
  var airspeedVelocity: Double {
    version * speedFactor
  }
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var obj = Stud()
        print(obj.name)
        obj.name = "random name"
//        obj.setName("Ramo")
        print(obj.name, obj.age)
        obj.age = 44
        print(obj.age)
        obj.greet()
        // Do any additional setup after loading the view.
        
        var swiftbird = SwiftBird(version: 33)
        var penguin = Penguin(airspeedVelocity: 44, name: "hasdf")
        var flappyBird = FlappyBird(name: "fbird", flappyAmplitude: 43, flappyFrequency: 3)
        print(swiftbird.self, swiftbird.canFly)
        print(penguin.self, penguin.canFly)
        print(flappyBird.self, flappyBird.canFly)
    }


}

