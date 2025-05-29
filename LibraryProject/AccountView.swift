import SwiftUI
import CoreData

struct AccountView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>

    @AppStorage("isLoggedIn") private var isLoggedIn = false

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var successMessage: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Text("Moje konto")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 16)

                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.headline)
                                .foregroundColor(.black)
                            TextField("Email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Hasło")
                                .font(.headline)
                                .foregroundColor(.black)
                            SecureField("Hasło", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }

                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.subheadline)
                        }

                        if !successMessage.isEmpty {
                            Text(successMessage)
                                .foregroundColor(.green)
                                .font(.subheadline)
                        }

                        Button(action: saveChanges) {
                            Text("Zapisz zmiany")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
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
                .onAppear(perform: loadUserData)
            }
            .navigationBarHidden(true)
        }
    }

    private func loadUserData() {
        if let user = users.first {
            email = user.email ?? ""
            password = user.password ?? ""
        }
    }

    private func saveChanges() {
        guard let user = users.first else {
            errorMessage = "Nie znaleziono użytkownika."
            successMessage = ""
            return
        }

        guard !email.isEmpty else {
            errorMessage = "Email nie może być pusty."
            successMessage = ""
            return
        }

        // Prosta walidacja emaila (możesz rozszerzyć)
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Nieprawidłowy format emaila."
            successMessage = ""
            return
        }

        user.email = email

        if !password.isEmpty {
            user.password = password
        }

        do {
            try viewContext.save()
            errorMessage = ""
            successMessage = "Dane zapisane pomyślnie."
            password = "" // Wyczyść pole hasła po zmianie
        } catch {
            errorMessage = "Błąd zapisu: \(error.localizedDescription)"
            successMessage = ""
        }
    }
}

struct MenuRow1: View {
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
    AccountView()
}
