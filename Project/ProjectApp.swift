//
//  projekt_swiftApp.swift
//  projekt_swift
//
//  Created by Agnieszka Marzeda on 04/04/2025.
//

import SwiftUI

@main
struct ProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    preloadAllData(context: persistenceController.container.viewContext)
                }
        }
    }
}
