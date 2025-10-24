//
//  DatabaseService.swift
//  TestList
//
//  Created by Asif Habib on 15/09/25.
//
import RealmSwift

class DatabaseService: DatabaseServiceProtocol {
    let realmObj = try! Realm()
    func fetchUsers() async throws -> [User] {
        realmObj.objects([User].self).map(\.toModel)
    }
    
    func saveUsers(_ users: [User]) {
        realmObj.beginWrite()
        realmObj.add(users.map(\.self), update: .all)
        try! realmObj.commitWrite()
    }
    
    
}
