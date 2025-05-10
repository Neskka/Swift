//
//  LibraryProjectApp.swift
//  LibraryProject
//
//  Created by Agnieszka Marzeda on 10/05/2025.
//

import SwiftUI

@main
struct LibraryProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
