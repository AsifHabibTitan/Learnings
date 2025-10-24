//
//  User.swift
//  MVVMTest
//
//  Created by Asif Habib on 15/09/25.
//

struct User: Decodable {
    var id: Int
    var name: String
    var email: String
//    var username: String
    var toEntity: UserEntity {
        return UserEntity(id: id, name: name, email: email)
    }
}
