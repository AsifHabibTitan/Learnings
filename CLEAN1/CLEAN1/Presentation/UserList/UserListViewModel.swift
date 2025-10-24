//
//  UserListViewModel.swift
//  CLEAN
//
//  Created by Asif Habib on 05/09/25.
//

import Foundation
import Combine

final class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let fetchUsersUseCase: FetchUsersUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(fetchUsersUseCase: FetchUsersUseCaseProtocol) {
        self.fetchUsersUseCase = fetchUsersUseCase
    }

    func fetchUsers() {
        isLoading = true
        errorMessage = nil

        fetchUsersUseCase.execute()
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
    }
}
