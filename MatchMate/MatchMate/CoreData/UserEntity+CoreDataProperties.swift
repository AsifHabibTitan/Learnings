//
//  UserEntity+CoreDataProperties.swift
//  MatchMate
//
//  Created by Asif Habib on 31/07/25.
//

import Foundation
import CoreData

extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var uuid: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var age: Int16
    @NSManaged public var gender: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var pictureURL: String?
    @NSManaged public var accepted: NSNumber?
}
