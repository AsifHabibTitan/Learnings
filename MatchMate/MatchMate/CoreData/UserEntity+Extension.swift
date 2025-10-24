//
//  UserEntity+Extension.swift
//  MatchMate
//
//  Created by Asif Habib on 31/07/25.
//

import Foundation
import CoreData

extension UserEntity {
    /// Convert a Core Data UserEntity into a UserModel
    func toUserModel() -> ProfileModel {
        return ProfileModel(
            gender: self.gender ?? "",
            name: Name(title: "", first: self.firstName ?? "", last: self.lastName ?? ""),
            location: Location(
                street: Street(number: 0, name: ""),
                city: self.city ?? "",
                state: self.state ?? "",
                country: "",
                postcode: .string(""),
                coordinates: Coordinates(latitude: "", longitude: ""),
                timezone: Timezone(offset: "", description: "")
            ),
            email: self.email ?? "",
            login: Login(uuid: self.uuid ?? "", username: "", password: "", salt: "", md5: "", sha1: "", sha256: ""),
            dob: DateOfBirth(date: "", age: Int(self.age)),
            registered: Registered(date: "", age: 0),
            phone: self.phone ?? "",
            cell: "",
            userID: UserID(name: "", value: nil),
            picture: Picture(large: self.pictureURL ?? "", medium: "", thumbnail: ""),
            nat: "",
            acceptanceStatus: self.accepted?.boolValue
        )
    }

    /// Update this UserEntity from a UserModel
    func update(from user: ProfileModel) {
        self.uuid = user.id
        self.firstName = user.name.first
        self.lastName = user.name.last
        self.email = user.email
        self.phone = user.phone
        self.age = Int16(user.age)
        self.gender = user.gender
        self.city = user.location.city
        self.state = user.location.state
        self.pictureURL = user.picture.large
        self.accepted = user.acceptanceStatus.map(NSNumber.init)
    }
}
