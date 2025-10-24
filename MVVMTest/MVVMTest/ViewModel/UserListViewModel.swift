//
//  UserListViewModel.swift
//  MVVMTest
//
//  Created by Asif Habib on 15/09/25.
//
import SwiftUI

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorString: String = ""
    var repository: UserRepository
    init(repository: UserRepository) {
        self.repository = repository
        Task { @MainActor in
            do {
                try await self.loadData()
            } catch {
                debugPrint(error)
                errorString = error.localizedDescription
            }
            
        }
    }
    @MainActor
    func loadData() async throws {

        var  users: [User] = try await repository.fetchUsers()
//        let users: [User] = try await APIService.shared.fetchData(url: url)
        self.users = users
        
    }
}
