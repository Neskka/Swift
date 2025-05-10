//
//  Order+CoreDataProperties.swift
//  LibraryProject
//
//  Created by Agnieszka Marzeda on 10/05/2025.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var date: Date?
    @NSManaged public var deliveryAddress: String?
    @NSManaged public var id: UUID?
    @NSManaged public var paymentMethod: String?
    @NSManaged public var status: String?
    @NSManaged public var sum: Double
    @NSManaged public var toBook: Book?
    @NSManaged public var toBookstore: Bookstore?
    @NSManaged public var toUser: User?

}

extension Order : Identifiable {

}
