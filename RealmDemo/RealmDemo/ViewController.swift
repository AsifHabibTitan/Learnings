//
//  ViewController.swift
//  RealmDemo
//
//  Created by Asif Habib on 19/07/23.
//

import UIKit
import RealmSwift
class ViewController: UIViewController {
    var realm : Realm?
    @IBOutlet weak var ageOutlet: UITextField!
    @IBOutlet weak var nameOutlet: UITextField!
    
    @IBAction func generate(_ sender: UIButton) {
        print(self.realm?.objects(Person.self))
    }
    @IBAction func StoreData(_ sender: UIButton) {
        do {
            var person = Person()
            if nameOutlet.text != "" && ageOutlet.text != "" {
                if let name = nameOutlet.text{
                    person.name = name
                }
                if let age = ageOutlet.text {
                    person.age = Int(age)!
                }
                try self.realm?.write{
                    realm?.add(person)
                    print("added the object \(person)")
                    ageOutlet.text = ""
                    nameOutlet.text = ""
                }
            }
            
                
        } catch {
            print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let realmInstance = try! Realm()
        self.realm = realmInstance
    }


}

