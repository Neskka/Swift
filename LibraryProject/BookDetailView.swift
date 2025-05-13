//
//  BookDetailView.swift
//  LibraryProject
//
//  Created by Agnieszka Marzeda on 13/05/2025.
//

import SwiftUI
import CoreData

struct BookDetailView: View {
    let book: Book

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Okładka
                if let coverName = book.cover, !coverName.isEmpty {
                    Image(coverName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .cornerRadius(10)
                }

                // Tytuł
                Text(book.title ?? "Brak tytułu")
                    .font(.largeTitle)
                    .bold()

                // Autor
                Text("Autor: \(book.author ?? "Nieznany")")
                    .font(.title3)
                    .foregroundColor(.secondary)

                // Gatunek
                if let category = book.category, !category.isEmpty {
                    Text("Gatunek: \(category)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                // Opis
                if let descriptionText = book.descriptionText, !descriptionText.isEmpty {
                    Text("Opis")
                        .font(.headline)
                        .padding(.top, 10)
                    Text(descriptionText)
                        .font(.body)
                }

                // ISBN
                if let isbn = book.isbn, !isbn.isEmpty {
                    Text("ISBN: \(isbn)")
                        .font(.footnote)
                        .padding(.top, 8)
                        .foregroundColor(.gray)
                }

                // Cena
                Text("Cena: \(String(format: "%.2f", book.price)) zł")
                    .font(.headline)
                    .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Szczegóły książki")
        .navigationBarTitleDisplayMode(.inline)
    }
}
