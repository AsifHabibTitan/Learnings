//
//  UserEntity.swift
//  MVVMTest
//
//  Created by Asif Habib on 15/09/25.
//
import RealmSwift

class UserEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var email: String
    
    convenience init(id: Int, name: String, email: String) {
        self.init()
        self.id = id
        self.name = name
        self.email = email
    }
    
    var toModel: User {
        return User(id: self.id, name: name, email: email)
    }
    
}
