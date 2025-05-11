//
//  Persistence.swift
//  LibraryProject
//
//  Created by Agnieszka Marzeda on 10/05/2025.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let context = result.container.viewContext

        // Załaduj dane testowe
        preloadSampleBooks(context: context)

        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        guard let modelURL = Bundle.main.url(forResource: "LibraryProject", withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Nie można znaleźć modelu danych")
        }

        container = NSPersistentContainer(name: "LibraryProject", managedObjectModel: managedObjectModel)

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Błąd ładowania persistent store: \(error), \(error.userInfo)")
            }
        }
    }

}
