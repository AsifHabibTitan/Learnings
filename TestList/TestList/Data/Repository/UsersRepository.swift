//
//  UsersRepository.swift
//  TestList
//
//  Created by Asif Habib on 15/09/25.
//

import Foundation
protocol UsersRepositoryProtocol {
    func fetchUsers() async throws -> [User]
}
protocol DatabaseServiceProtocol {
    func fetchUsers() async throws -> [User]
    func saveUsers(_ users: [User])
}
protocol APIServiceProtocol {
    func fetchUsers() async throws -> [User]
}
class UsersRepository: UsersRepositoryProtocol {
    var databaseService: DatabaseServiceProtocol
    var apiService: APIServiceProtocol
    init(databaseService: DatabaseServiceProtocol, apiService: APIServiceProtocol) {
        self.databaseService = databaseService
        self.apiService = apiService
    }
    
    func fetchUsers() async throws -> [User] {
        let cachedUsers =  try await databaseService.fetchUsers()
        if !cachedUsers.isEmpty {
            return cachedUsers
        }
        let remoteUsers = try await apiService.fetchUsers()
        databaseService.saveUsers(remoteUsers)
        return remoteUsers
    }
}

