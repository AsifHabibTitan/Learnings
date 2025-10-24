//
//  FetchUsersUsecase.swift
//  CLEAN
//
//  Created by Asif Habib on 05/09/25.
//

import Foundation
import Combine

protocol FetchUsersUseCaseProtocol {
    func execute() -> AnyPublisher<[User], NetworkError>
}

final class FetchUsersUseCaseImpl: FetchUsersUseCaseProtocol {
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[User], NetworkError> {
        return repository.fetchUsers()
    }
}
