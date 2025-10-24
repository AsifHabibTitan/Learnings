//
//  apiService.swift
//  MatchMate
//
//  Created by Asif Habib on 30/07/25.
//

import Foundation

//enum APIEndpoint: String {
//    case profiles = "/api/?results=10"
//    case verifyOTP = "/V1/users/verify_otp"
//    case testProfileList = "/V1/users/test_profile_list"
//    
//    var path: String {
//        return self.rawValue
//    }
//}
enum APIEndPoint {
    case getProfiles(page: Int, results: Int)
    
    var path: String {
        switch self {
        case .getProfiles(page: let page, results: let results):
            return "/api/?page=\(page)&results=\(results)&seed=asif_habib_matchmate"
        }
    }
}


class APIService {
    static let shared = APIService()
    private init() {}

    private let baseURL = "https://randomuser.me"
    
    func get<T: Decodable>(_ endpoint: APIEndPoint,
                           headers: [String: String]? = nil,
                           responseType: T.Type,
                           completion: @escaping (Result<T, Error>) -> Void) {
        
        // Ensure no double slashes in final URL
        let fullPath = baseURL + endpoint.path
        guard let url = URL(string: fullPath) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            self.handleResponse(data: data, error: error, completion: completion)
        }.resume()
    }

    private func handleResponse<T: Decodable>(data: Data?, error: Error?, completion: @escaping (Result<T, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(APIError.noData))
            return
        }

        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decoded))
        } catch {
            completion(.failure(error))
        }
    }

    enum APIError: Error {
        case invalidURL
        case noData
    }
}
