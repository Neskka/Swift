//
//  Bookstore+CoreDataProperties.swift
//  LibraryProject
//
//  Created by Agnieszka Marzeda on 10/05/2025.
//
//

import Foundation
import CoreData


extension Bookstore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookstore> {
        return NSFetchRequest<Bookstore>(entityName: "Bookstore")
    }

    @NSManaged public var address: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var hasApp: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: Int64
    @NSManaged public var rating: Double
    @NSManaged public var toBook: Book?
    @NSManaged public var toOrder: Order?

}

extension Bookstore : Identifiable {

}
