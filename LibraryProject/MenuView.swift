import SwiftUI

struct MenuView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        NavigationView {
            ZStack {
                // Tło takie jak w LoginView
                BackgroundView()
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Text("Panel użytkownika")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 16)

                    VStack(spacing: 16) {
                        NavigationLink(destination: AccountView()) {
                            MenuRow(title: "Moje konto")
                        }

                        NavigationLink(destination: LibraryView()) {
                            MenuRow(title: "Moje książki")
                        }

                        NavigationLink(destination: BookView()) {
                            MenuRow(title: "Katalog")
                        }
                    }
                    .padding(.horizontal, 24)

                    Spacer()

                    Button(action: {
                        isLoggedIn = false
                    }) {
                        Text("Wyloguj się")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                }
                .frame(maxWidth: 350)
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(20)
                .shadow(radius: 8)
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct MenuRow: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.black)
                .font(.title3)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.6))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    MenuView()
}
