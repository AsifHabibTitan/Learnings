//
//  APIService.swift
//  MVVMTest
//
//  Created by Asif Habib on 15/09/25.
//
import Foundation

class APIService: APIServiceProtocol {
    func fetchUsers() async throws -> [User] {
        let users: [User] = try await fetchData(url: URL(string: "https://jsonplaceholder.typicode.com/users")!)
        return users
    }
    
    static let shared = APIService()
    private init(){}
    
    func fetchData<T: Decodable>(url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
            
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
}
