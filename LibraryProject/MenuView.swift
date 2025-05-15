//
//  MenuView.swift
//  LibraryProject
//
//  Created by Agnieszka Marzeda on 15/05/2025.
//

import Foundation
import SwiftUI

struct MenuView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var selection: Int? = nil

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                NavigationLink(destination: AccountView(), tag: 1, selection: $selection) {
                    EmptyView()
                }

                Button(action: {
                    selection = 1
                }) {
                    Text("Moje konto")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.vertical, 8)
                }

                Divider()

                Button(action: {
                    print("Moje książki")
                }) {
                    Text("Moje książki")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.vertical, 8)
                }

                Button(action: {
                    print("Katalog")
                }) {
                    Text("Katalog")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.vertical, 8)
                }

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
            }
            .padding()
            .navigationTitle("Panel użytkownika")
        }
    }
}

#Preview {
    MenuView()
}
