//
//  APIService.swift
//  Aisle_Notes
//
//  Created by Asif Habib on 18/07/25.
//

import Foundation

enum APIEndpoint: String {
    case login = "/V1/users/phone_number_login"
    case verifyOTP = "/V1/users/verify_otp"
    case testProfileList = "/V1/users/test_profile_list"
    
    var path: String {
        return self.rawValue
    }
}

class APIService {
    static let shared = APIService()
    private init() {}

    private let baseURL = "https://app.aisle.co"

    func get<T: Decodable>(_ endpoint: APIEndpoint,
                           headers: [String: String]? = nil,
                           responseType: T.Type,
                           completion: @escaping (Result<T, Error>) -> Void) {

        guard let url = URL(string: baseURL + endpoint.path) else {
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

    func post<T: Decodable>(
        _ endpoint: APIEndpoint,
        body: [String: Any],
        headers: [String: String]? = nil,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: baseURL + endpoint.path) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
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
