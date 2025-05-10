//
//  User+CoreDataProperties.swift
//  LibraryProject
//
//  Created by Agnieszka Marzeda on 10/05/2025.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: Int64
    @NSManaged public var toBook: Book?
    @NSManaged public var toOrder: Order?

}

extension User : Identifiable {

}
