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
            TabView {
                BookView()
                    .tabItem {
                        Image(systemName: "book.fill")
                        Text("Strona Główna")
                    }

                if isLoggedIn {
                    AccountView()
                        .tabItem {
                            Image(systemName: "person.crop.circle.fill")
                            Text("Moje Konto")
                        }

                    MenuView()
                        .tabItem {
                            Image(systemName: "list.bullet.rectangle.portrait")
                            Text("Menu")
                        }
                } else {
                    LoginView()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Logowanie")
                        }

                    RegisterView()
                        .tabItem {
                            Image(systemName: "person.badge.plus.fill")
                            Text("Rejestracja")
                        }
                }
            }
            .accentColor(.blue)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environment(\.managedObjectContext, context)
        .onAppear {
            // 🔁 Upewnij się, że to nie jest przy każdym uruchomieniu
            //if UserDefaults.standard.bool(forKey: "didPreload") == false {
                resetAllBooks(context: context)
                preloadSampleBooks(context: context)
                UserDefaults.standard.set(true, forKey: "didPreload")
            //}
        }
    }

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext

        // Tylko dla podglądu – reset i preload
        resetAllBooks(context: context)
        preloadSampleBooks(context: context)

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
