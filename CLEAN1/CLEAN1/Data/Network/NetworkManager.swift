//
//  NetworkManager.swift
//  CLEAN
//
//  Created by Asif Habib on 05/09/25.
//

import Foundation
import Combine
import Alamofire

protocol NetworkManagerProtocol {
    func getData<T: Decodable>(_ router: APIRouter) -> AnyPublisher<T, NetworkError>
}

class NetworkManager: NetworkManagerProtocol {
    func getData<T: Decodable>(_ router: APIRouter) -> AnyPublisher<T, NetworkError> {
        return AF.request(router)
            .publishDecodable(type: T.self)
            .tryMap { response -> T in
                guard let statusCode = response.response?.statusCode else {
                    throw NetworkError.unknown(statusCode: -1)
                }

                switch statusCode {
                case 200..<300:
                    if let value = response.value {
                        return value
                    } else {
                        throw NetworkError.decodingError
                    }

                case 401:
                    throw NetworkError.unauthorized
                case 403:
                    throw NetworkError.forbidden
                case 404:
                    throw NetworkError.notFound
                case 500..<600:
                    throw NetworkError.serverError
                default:
                    throw NetworkError.unknown(statusCode: statusCode)
                }
            }
            .mapError { error -> NetworkError in
                if let afError = error as? AFError {
                    return .afError(afError)
                } else if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return .unknown(statusCode: -1)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case unknown(statusCode: Int)
    case afError(AFError)

    var errorDescription: String? {
        switch self {
        case .unauthorized: return "Unauthorized (401)"
        case .forbidden: return "Forbidden (403)"
        case .notFound: return "Not Found (404)"
        case .serverError: return "Server Error"
        case .decodingError: return "Decoding Error"
        case .noData: return "No data received"
        case .invalidURL: return "Invalid URL"
        case .afError(let error): return error.localizedDescription
        case .unknown(let code): return "Unknown Error (status code: \(code))"
        }
    }
}
