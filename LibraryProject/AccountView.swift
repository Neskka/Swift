//
//  AccountView.swift
//  LibraryProject
//
//  Created by Agnieszka Marzeda on 15/05/2025.
//

import Foundation
import SwiftUI

struct AccountView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Informacje o koncie użytkownika")
                .font(.title)
                .padding(.top)

            // Tu możesz dodać więcej informacji użytkownika (np. email z Core Data)

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
            .padding(.bottom)
        }
        .padding()
        .navigationTitle("Moje konto")
    }
}

#Preview {
    AccountView()
}
