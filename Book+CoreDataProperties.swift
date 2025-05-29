//
//  Book+CoreDataProperties.swift
//  LibraryProject
//
//  Created by Agnieszka Marzeda on 10/05/2025.
//
//

import Foundation
import CoreData

extension Book {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var category: String?
    @NSManaged public var cover: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var price: Double
    @NSManaged public var isbn: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var publisher: String?
    @NSManaged public var pageCount: Int64
    @NSManaged public var rating: Double
    @NSManaged public var order: Int64
    @NSManaged public var readingTime: String?
    @NSManaged public var toUser: Set<User>?
    @NSManaged public var toBookstore: NSSet?
}
