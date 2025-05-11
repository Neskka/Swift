//
//  ContentView.swift
//  LibraryProject
//
//  Created by Agnieszka Marzeda on 10/05/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    private let context = PersistenceController.shared.container.viewContext
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                TabView {
                    BookView()
                        .tabItem {
                            Image(systemName: "book.fill")
                            Text("Strona Główna")
                        }
                    
                    //                    if isLoggedIn {
                    //                        AccountView()
                    //                            .tabItem {
                    //                                Image(systemName: "person.crop.circle.fill")
                    //                                Text("Moje Konto")
                    //                            }
                    //
                    //                        MenuView()
                    //                            .tabItem {
                    //                                Image(systemName: "list.bullet.rectangle.portrait")
                    //                                Text("Menu")
                    //                            }
                    //                    } else {
                    //                        LoginView()
                    //                            .tabItem {
                    //                                Image(systemName: "person.fill")
                    //                                Text("Logowanie")
                    //                            }
                    //
                    //                        RegisterView()
                    //                            .tabItem {
                    //                                Image(systemName: "person.badge.plus.fill")
                    //                                Text("Rejestracja")
                    //                            }
                    //                    }
                    //                }
                        .accentColor(.blue)
                }
                .background(Color.white)
                .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.managedObjectContext, context)
            .onAppear {
                preloadSampleBooks(context: context)
            }
        }
    }
    
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext

        let book = Book(context: context)
        book.id = UUID()
        book.title = "Przykładowa książka"
        book.author = "Autor Przykładowy"
        book.category = "Fantasy"
        book.descriptionText = "Opis próbny"
        book.price = 19.99

        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Nie można zapisać danych do podglądu: \(nsError), \(nsError.userInfo)")
        }

        return controller
    }()

}

#Preview {
    ContentView()
}
