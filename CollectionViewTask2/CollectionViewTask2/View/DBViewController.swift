//
//  DBViewController.swift
//  CollectionViewTask2
//
//  Created by Asif Habib on 18/07/23.
//

import Foundation
import RealmSwift

class DBViewController: UIViewController {
    override func viewDidLoad() {
        let realm = try! Realm()
        print(realm.configuration.fileURL)
        
        var person = Person(name: "Somename", age: 44)
        try! realm.write {
            realm.add(person)
        }
    }
}

