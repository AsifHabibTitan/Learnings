//
//  DatabaseService.swift
//  MVVMTest
//
//  Created by Asif Habib on 16/09/25.
//
import RealmSwift
import Foundation

class DatabaseService: DatabaseServiceProtocol {
    
//    func fetchUsers() async throws -> [User] {
//        let realmObj = try await Realm()
//        let users = realmObj.objects(UserEntity.self).map(\.toModel)
//        return Array(users)
//    }
    func fetchUsers() async throws -> [User] {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        return try await withCheckedThrowingContinuation { continuation in
            Task.detached(operation: {
                debugPrint("Thread type global \(Thread.isMainThread)")
                do {
                    let realm = try Realm(configuration: config)
                    let entities = realm.objects(UserEntity.self)
                    let users = Array(entities.map(\.toModel))
                    continuation.resume(returning: users)
                } catch {
                    continuation.resume(throwing: error)
                }
            })
                
            
        }
    }
    
    func saveUsers(_ users: [User]) {
        let realmObj = try! Realm()
        realmObj.beginWrite()
        realmObj.add(users.map(\.toEntity), update: .all)
        do {
            try realmObj.commitWrite()
        } catch {
            debugPrint(
                "can't save users to database: \(error.localizedDescription)"
            )
        }
        
    }
    
    
}
