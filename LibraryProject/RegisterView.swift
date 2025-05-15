//
//  RegisterView.swift
//  LibraryProject
//
//  Created by Agnieszka Marzeda on 15/05/2025.
//

import SwiftUI
import CoreData

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        ZStack {
            BackgroundView()

            VStack {
                Spacer()
                RegisterFormView(email: $email, password: $password, confirmPassword: $confirmPassword)
                Spacer()
            }
        }
    }
}

struct RegisterFormView: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String

    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.badge.plus.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue)

            Text("Rejestracja")
                .font(.title3)
                .fontWeight(.bold)

            TextField("Adres e-mail", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)

            SecureField("Hasło", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Potwierdź hasło", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Button("Zarejestruj") {
                register()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: 300)
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.9)))
        .padding()
    }

    private func register() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Wypełnij wszystkie pola."
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Hasła się różnią."
            return
        }

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)

        do {
            let existingUsers = try viewContext.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                errorMessage = "Użytkownik już istnieje."
                return
            }

            let newUser = User(context: viewContext)
            newUser.email = email
            newUser.password = password

            try viewContext.save()
            isLoggedIn = true
        } catch {
            errorMessage = "Błąd podczas rejestracji."
        }
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
