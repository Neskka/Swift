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
            }
            .background(Color.white)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environment(\.managedObjectContext, context) 
        .onAppear {
            preloadAllData(context: context)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
