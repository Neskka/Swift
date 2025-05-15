//
//  LoginView.swift
//  LibraryProject
//
//  Created by Agnieszka Marzeda on 15/05/2025.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        ZStack {
            BackgroundView()

            VStack {
                Spacer()
                LoginFormView(email: $email, password: $password)
                Spacer()
            }
        }
    }
}

struct LoginFormView: View {
    @Binding var email: String
    @Binding var password: String
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @Environment(\.managedObjectContext) private var viewContext

    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue)

            Text("Logowanie")
                .font(.title3)
                .fontWeight(.bold)

            TextField("Adres e-mail", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)

            SecureField("Hasło", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Button("Zaloguj") {
                login()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: 300)
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.9)))
        .padding()
    }

    private func login() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)

        do {
            let users = try viewContext.fetch(request)
            if users.first != nil {
                isLoggedIn = true
            } else {
                errorMessage = "Nieprawidłowy email lub hasło."
            }
        } catch {
            errorMessage = "Błąd logowania."
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
