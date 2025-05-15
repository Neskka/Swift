//
//  BookView.swift
//  LibraryProject
//
//  Created by Agnieszka Marzeda on 11/05/2025.
//

import SwiftUI
import CoreData

struct BookView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true)],
        animation: .default)
    private var books: FetchedResults<Book>
    
    @State private var searchText = ""
    @State private var selectedGenre: String = "Wszystko"
    
    let genres = ["Wszystko", "Fantasy", "Thriller", "Sci-Fi", "Romans", "Literatura piękna", "Dystopia", "Powieść historyczna", "Przygodowa", "Reportaż", "Powieść psychologiczna"]
    
    var filteredBooks: [Book] {
        books.filter { book in
            let genreMatch = selectedGenre == "Wszystko" || (book.category ?? "") == selectedGenre
            let textMatch = searchText.isEmpty ||
            (book.title?.localizedCaseInsensitiveContains(searchText) ?? false) ||
            (book.author?.localizedCaseInsensitiveContains(searchText) ?? false)
            return genreMatch && textMatch
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Szukaj książki...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 8)
                        .padding(.trailing, 8)
                    
                    Picker("Wybierz gatunek", selection: $selectedGenre) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                }
                
                List(filteredBooks, id: \.self) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        VStack(alignment: .leading) {
                            if let cover = book.cover, UIImage(named: cover) != nil {
                                Image(cover)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150)
                                    .cornerRadius(8)
                            }
                            
                            Text(book.title ?? "Brak tytułu")
                                .font(.headline)
                            Text("Autor: \(book.author ?? "Nieznany")")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .navigationTitle("Katalog książek")
            }
        }
    }
}
