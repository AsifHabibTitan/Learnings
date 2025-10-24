//
//  UserRepository.swift
//  CLEAN
//
//  Created by Asif Habib on 05/09/25.
//

import Combine



protocol UserRepository {
    func fetchUsers() -> AnyPublisher<[User], NetworkError>
}

final class UserRepositoryImpl: UserRepository {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchUsers() -> AnyPublisher<[User], NetworkError> {
        networkManager.getData(.getUsers)
    }
}


struct User: Identifiable, Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat: String
    let lng: String
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
