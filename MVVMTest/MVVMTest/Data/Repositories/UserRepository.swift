//
//  UserRepository.swift
//  MVVMTest
//
//  Created by Asif Habib on 15/09/25.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUsers() async throws -> [User]
}
protocol APIServiceProtocol {
    func fetchUsers() async throws -> [User]
}
protocol DatabaseServiceProtocol {
    func fetchUsers() async throws -> [User]
    func saveUsers(_ users: [User])
}

class UserRepository: UserRepositoryProtocol {
    var apiService: APIServiceProtocol
    var dbService: DatabaseServiceProtocol
    init(apiService: APIServiceProtocol, dbService: DatabaseServiceProtocol) {
        self.apiService = apiService
        self.dbService = dbService
    }
    func fetchUsers() async throws -> [User] {
        let cachedUsers = try await dbService.fetchUsers()
        if !cachedUsers.isEmpty {
            return cachedUsers
        }
        let remoteUsers = try await apiService.fetchUsers()
        dbService.saveUsers(remoteUsers)
        return remoteUsers
    }
    
    
}
 
