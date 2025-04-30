// BookDetailView.swift
import SwiftUI
import CoreData

struct BookDetailView: View {
    let book: Books

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let cover = book.cover, !cover.isEmpty {
                    Image(cover)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .cornerRadius(10)
                }

                Text(book.title ?? "Brak tytułu")
                    .font(.largeTitle)
                    .bold()

                Text("Autor: \(book.author ?? "Nieznany")")
                    .font(.title3)
                    .foregroundColor(.secondary)

                if let category = book.category {
                    Text("Gatunek: \(category)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                if let desc = book.descriptionText {
                    Text(desc)
                        .font(.body)
                        .padding(.top)
                }

                if let isbn = book.isbn {
                    Text("ISBN: \(isbn)")
                        .font(.footnote)
                        .padding(.top, 8)
                }

                Text(String(format: "Cena: %.2f zł", book.price))
                    .font(.headline)
                    .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Szczegóły książki")
    }
}
