//
//  SampleData.swift
//  Project
//
//  Created by Agnieszka Marzeda on 11/04/2025.
//

import Foundation
import CoreData

func preloadAllData(context: NSManagedObjectContext) {
    preloadBookstores(context: context)
    preloadUsers(context: context)
    preloadOrders(context: context)
    preloadBooks(context: context)
}

// MARK: - Bookstores
func preloadBookstores(context: NSManagedObjectContext) {
    let request: NSFetchRequest<Bookstores> = Bookstores.fetchRequest()
    request.fetchLimit = 1

    do {
        let count = try context.count(for: request)
        if count == 0 {
            let data = [
                ("Empik Warszawa", "ul. Marszałkowska 104/122", 52.2297, 21.0122, 4.5, true, "Sieć księgarni z dużym wyborem", 123456789),
                ("Księgarnia Kraków", "ul. Floriańska 25", 50.0647, 19.9450, 4.2, false, "Kameralna księgarnia w centrum", 987654321),
                ("BookHouse Wrocław", "ul. Legnicka 58", 51.1079, 17.0385, 4.8, true, "Nowoczesna księgarnia", 111222333)
            ]

            for (name, address, lat, lon, rating, hasApp, desc, phone) in data {
                let store = Bookstores(context: context)
                store.id = UUID()
                store.name = name
                store.address = address
                store.latitude = lat
                store.longtitude = lon
                store.rating = rating
                store.hasApp = hasApp
                store.descriptionText = desc
                store.phoneNumber = Int64(phone)
            }

            try context.save()
            print("Bookstores załadowane")
        }
    } catch {
        print("Błąd Bookstores: \(error)")
    }
}

// MARK: - Users
func preloadUsers(context: NSManagedObjectContext) {
    let request: NSFetchRequest<Users> = Users.fetchRequest()
    request.fetchLimit = 1

    do {
        let count = try context.count(for: request)
        if count == 0 {
            let data = [
                ("Jan", "Kowalski", "jan.kowalski@email.com", "tajnehaslo", 501234567),
                ("Anna", "Nowak", "anna.nowak@email.com", "haslo123", 502345678),
                ("Piotr", "Zieliński", "piotr.z@email.com", "zielonehaslo", 503456789)
            ]

            for (firstName, lastName, email, password, phone) in data {
                let user = Users(context: context)
                user.id = UUID()
                user.firstName = firstName
                user.lastName = lastName
                user.email = email
                user.password = password
                user.phoneNumber = Int64(phone)
            }

            try context.save()
            print("Users załadowani")
        }
    } catch {
        print("Błąd Users: \(error)")
    }
}

// MARK: - Orders
func preloadOrders(context: NSManagedObjectContext) {
    let request: NSFetchRequest<Orders> = Orders.fetchRequest()
    request.fetchLimit = 1

    do {
        let count = try context.count(for: request)
        if count == 0 {
            let data = [
                (Date(), "ul. Wesoła 10", "Karta", "Dostarczone", 99.99),
                (Date(), "ul. Smutna 3", "Blik", "W realizacji", 55.49),
                (Date(), "ul. Główna 12", "PayPal", "Wysłane", 78.00)
            ]

            for (date, address, payment, status, sum) in data {
                let order = Orders(context: context)
                order.id = UUID()
                order.date = date
                order.deliveryAddress = address
                order.paymentMethod = payment
                order.status = status
                order.sum = sum
            }

            try context.save()
            print("Orders załadowane")
        }
    } catch {
        print("Błąd Orders: \(error)")
    }
}

// MARK: - Books
func preloadBooks(context: NSManagedObjectContext) {
    let request: NSFetchRequest<Books> = Books.fetchRequest()
    request.fetchLimit = 1

    do {
        let count = try context.count(for: request)
        if count == 0 {
            let data = [
                ("Wiedźmin: Ostatnie życzenie", "Andrzej Sapkowski", "Fantasy", "cover_wiedzmin.jpg", "Pierwszy tom przygód Geralta z Rivii", "9788375780635", 34.99),
                ("Lalka", "Bolesław Prus", "Klasyka", "cover_lalka.jpg", "Powieść o losach Stanisława Wokulskiego", "9788306030198", 24.50),
                ("Zbrodnia i kara", "Fiodor Dostojewski", "Klasyka", "cover_zbrodnia.jpg", "Mroczna historia Raskolnikowa", "9780143058144", 29.90),
                ("Harry Potter i Kamień Filozoficzny", "J.K. Rowling", "Fantasy", "cover_hp1.jpg", "Pierwszy tom serii o młodym czarodzieju", "9788372780126", 39.90)
            ]

            for (title, author, category, cover, desc, isbn, price) in data {
                let book = Books(context: context)
                book.id = UUID()
                book.title = title
                book.author = author
                book.category = category
                book.cover = cover
                book.descriptionText = desc
                book.isbn = isbn
                book.price = price
            }

            try context.save()
            print("Books załadowane")
        }
    } catch {
        print("Błąd Books: \(error)")
    }
}
