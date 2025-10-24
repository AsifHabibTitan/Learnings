//
//  APIService.swift
//  TestList
//
//  Created by Asif Habib on 05/09/25.
//
//import Combine
//import Foundation
//
//class APIService {
//    func getUsers(url: String) async throws -> [User] {
//        let url = URL(string: url)!
//        let (data, res) = try await URLSession.shared.data(from: url)
//        return try JSONDecoder().decode([User].self, from: data)
//    }
//}
import Foundation
public struct Post: Codable ,Identifiable,Hashable {
 let userId: Int
 public let id: Int
 let title: String
 let body: String
}
public protocol NetworkRepositoryProtocol {
    func fetchData() async throws -> [Post]
}


public class NetworkRepository : NetworkRepositoryProtocol{
 let urlString = "https://jsonplaceholder.typicode.com/posts"
 
 public func fetchData() async throws -> [Post] {
     guard let url = URL(string: urlString) else {
     fatalError("Invalid URL")
     }
     let (data ,response) = try await URLSession.shared.data(from: url)
     guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
     fatalError("Failed to fetch data")
     }
     let finalRes = try JSONDecoder().decode([Post].self, from: data)
         print("data fetched", finalRes)
     return finalRes
 }
}
