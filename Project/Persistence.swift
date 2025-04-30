import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // Używane do podglądów SwiftUI (.preview)
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // Można tu załadować dane testowe (opcjonalnie)
        preloadAllData(context: viewContext)

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("❌ Nie udało się zapisać kontekstu w trybie preview: \(nsError), \(nsError.userInfo)")
        }

        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Books") // 👈 nazwa musi się zgadzać z .xcdatamodeld
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("❌ Błąd podczas ładowania persistent store: \(error), \(error.userInfo)")
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
