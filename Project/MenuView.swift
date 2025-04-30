import SwiftUI

struct MenuView: View {
    @State private var showAccountView = false
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: AccountView(), isActive: $showAccountView) {
                    Button(action: {
                        showAccountView = true
                    }) {
                        Text("Moje konto")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .foregroundColor(.blue)
                    }
                }

                Divider()
                    .overlay(Rectangle().frame(height: 2).foregroundColor(.black))

                Button(action: {
                    print("Moje książki")
                }) {
                    Text("Moje książki")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .foregroundColor(.blue)
                }

                Button(action: {
                    print("Katalog")
                }) {
                    Text("Katalog")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .foregroundColor(.blue)
                }

                Spacer()

                Button(action: {
                    isLoggedIn = false
                }) {
                    Text("Wyloguj się")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .foregroundColor(.red)
                        .background(Color.cyan)
                }
            }
            .navigationBarItems(trailing: Text("Panel użytkownika").font(.title))
            .padding()
        }
    }
}

#Preview {
    MenuView()
}
