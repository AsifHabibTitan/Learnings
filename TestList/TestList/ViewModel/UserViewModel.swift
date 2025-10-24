//
//  UserViewModel.swift
//  TestList
//
//  Created by Asif Habib on 05/09/25.
//

import Foundation

struct User: Decodable {
    var name: String
    var age: Int
}
class UserViewModel : ObservableObject{
    @Published var users: [Post] = []
    var networkRepo: NetworkRepositoryProtocol
    init(repo: NetworkRepositoryProtocol) {
        self.networkRepo = repo
        Task {
            let result = try await self.fetchUsers()
            await MainActor.run {
                users = result
            }
            
        }
        
    }
    
    private func fetchUsers() async throws -> [Post] {
        try await networkRepo.fetchData()
    }
}
