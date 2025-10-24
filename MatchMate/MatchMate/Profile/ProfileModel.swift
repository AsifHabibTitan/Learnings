//
//  UserModel.swift
//  MatchMate
//
//  Created by Asif Habib on 30/07/25.
//

import Foundation

// MARK: - API Response Structure
struct APIResponse: Codable {
    let results: [ProfileModel]
    let info: Info
}

struct Info: Codable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

// MARK: - User Model
struct ProfileModel: Codable, Identifiable, Equatable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: DateOfBirth
    let registered: Registered
    let phone: String
    let cell: String
    let userID: UserID
    let picture: Picture
    let nat: String
    
    // User decision status (nil = not decided, true = accepted, false = rejected)
    var acceptanceStatus: Bool?
    
    // Computed property for unique identifier (for Identifiable protocol)
    var id: String {
        return login.uuid
    }
    
    // Custom coding keys to handle the API's "id" field
    enum CodingKeys: String, CodingKey {
        case gender, name, location, email, login, dob, registered, phone, cell, picture, nat
        case userID = "id"  // Map API's "id" field to our "userID" property
    }
    
    // Computed property for full name
    var fullName: String {
        return "\(name.first) \(name.last)"
    }
    
    // Computed property for age
    var age: Int {
        return dob.age
    }
    
    // Computed property for location string
    var locationString: String {
        return "\(location.city), \(location.state)"
    }
}

// MARK: - Nested Structures
struct Name: Codable, Equatable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable, Equatable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Postcode
    let coordinates: Coordinates
    let timezone: Timezone
}

struct Street: Codable, Equatable {
    let number: Int
    let name: String
}

struct Coordinates: Codable, Equatable {
    let latitude: String
    let longitude: String
}

struct Timezone: Codable, Equatable {
    let offset: String
    let description: String
}

struct Login: Codable, Equatable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

struct DateOfBirth: Codable, Equatable {
    let date: String
    let age: Int
}

struct Registered: Codable, Equatable {
    let date: String
    let age: Int
}

struct UserID: Codable, Equatable {
    let name: String
    let value: String?
}

struct Picture: Codable, Equatable {
    let large: String
    let medium: String
    let thumbnail: String
}

// MARK: - Postcode Union Type
enum Postcode: Codable, Equatable {
    case string(String)
    case integer(Int)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else if let intValue = try? container.decode(Int.self) {
            self = .integer(intValue)
        } else {
            throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected string or integer"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .integer(let value):
            try container.encode(value)
        }
    }
} 
