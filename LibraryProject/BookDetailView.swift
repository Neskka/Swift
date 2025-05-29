import SwiftUI
import CoreData

struct BookDetailView: View {
    let book: Book
    @State private var isCoverFullScreen = false
    @State private var showMap = false
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: User.entity(), sortDescriptors: []) private var users: FetchedResults<User>


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Okładka z możliwością powiększenia
                if let coverName = book.cover, !coverName.isEmpty {
                    Image(coverName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .cornerRadius(10)
                        .onTapGesture {
                            isCoverFullScreen = true
                        }
                }

                // Tytuł
                Text(book.title ?? "Brak tytułu")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                // Autor
                Text("Autor: \(book.author ?? "Nieznany")")
                    .font(.title3)
                    .foregroundColor(.black)
                
                // Ocena nad opisem
                if book.rating > 0 {
                    HStack(spacing: 6) {
                        Text(String(format: "Ocena: %.1f", book.rating))
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        StarRatingView(rating: book.rating)
                            .font(.title2)
                    }
                    .padding(.top, 8)
                }

                // Gatunek
                if let category = book.category, !category.isEmpty {
                    Text("Gatunek: \(category)")
                        .font(.headline)
                        .foregroundColor(.black)
                }

                // Wydawnictwo
                if let publisher = book.publisher, !publisher.isEmpty {
                    Text("Wydawnictwo: \(publisher)")
                        .font(.headline)
                        .foregroundColor(.black)
                }

                // Data wydania
                if let releaseDate = book.releaseDate {
                    Text("Data wydania: \(formattedDate(releaseDate))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                // Liczba stron
                if book.pageCount > 0 {
                    Text("Liczba stron: \(book.pageCount)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                // Czas czytania
                if let readingTime = book.readingTime, !readingTime.isEmpty {
                    Text("Szacowany czas czytania: \(readingTime)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                // Opis
                if let descriptionText = book.descriptionText, !descriptionText.isEmpty {
                    Text("Opis")
                        .font(.title2)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                    Text(descriptionText)
                        .font(.body)
                        .foregroundColor(.black)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(5)
                }

                // ISBN
                if let isbn = book.isbn, !isbn.isEmpty {
                    Text("ISBN: \(isbn)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }

                // Cena
                Text("Cena: \(String(format: "%.2f", book.price)) zł")
                    .font(.title3)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .padding(.top)
                
                if isLoggedIn {
                    HStack(spacing: 20) {
                        Button(action: {
                            addToFavorites()
                        }) {
                            Text("Dodaj do ulubionych")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            showMap = true
                        }) {
                            Text("Sprawdź dostępność")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .sheet(isPresented: $showMap) {
                            MapView()
                        }
                    }
                    .padding(.horizontal)

                }
            }
            .padding()
        }
        .navigationTitle("Szczegóły książki")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $isCoverFullScreen) {
            ZStack(alignment: .topTrailing) {
                Color.black.ignoresSafeArea()
                if let coverName = book.cover, !coverName.isEmpty {
                    Image(coverName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            isCoverFullScreen = false
                        }
                }
                Button(action: {
                    isCoverFullScreen = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 36))
                        .foregroundColor(.white)
                        .padding()
                }
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "pl_PL")
        return formatter.string(from: date)
    }
    
    func addToFavorites() {
        guard let currentUser = users.first else {
            print("Brak aktualnego użytkownika")
            return
        }

        let favorites = currentUser.mutableSetValue(forKey: "toBook")
        favorites.add(book)

        do {
            try viewContext.save()
            print("Dodano do ulubionych: \(book.title ?? "")")
        } catch {
            print("Błąd zapisu: \(error.localizedDescription)")
        }
    }

}

struct StarRatingView: View {
    let rating: Double

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                star(for: index)
                    .foregroundColor(.yellow)
            }
        }
    }

    private func star(for index: Int) -> some View {
        let fillLevel = rating - Double(index)
        if fillLevel >= 1 {
            return Image(systemName: "star.fill").eraseToAnyView()
        } else if fillLevel > 0 {
            return Image(systemName: "star.leadinghalf.fill").eraseToAnyView()
        } else {
            return Image(systemName: "star").eraseToAnyView()
        }
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
