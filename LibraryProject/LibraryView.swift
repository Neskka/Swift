import SwiftUI
import CoreData

struct LibraryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: User.entity(), sortDescriptors: []) private var users: FetchedResults<User>
    
    @State private var showCoverFullScreen: Bool = false
    @State private var selectedCoverName: String? = nil
    
    // Pobierz aktualnego użytkownika
    var currentUser: User? {
        users.first
    }
    
    // Posortowane ulubione książki wg 'order'
    var favoriteBooks: [Book] {
        guard let booksSet = currentUser?.toBook as? Set<Book> else { return [] }
        return booksSet.sorted { $0.order < $1.order }
    }
    
    var body: some View {
        NavigationView {
            List {
                if favoriteBooks.isEmpty {
                    Text("Brak książek w biblioteczce.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(favoriteBooks, id: \.self) { book in
                        HStack(spacing: 12) {
                            // Miniaturka okładki z LongPress
                            if let coverName = book.cover, !coverName.isEmpty {
                                Image(coverName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 75)
                                    .cornerRadius(4)
                                    .clipped()
                                    .onLongPressGesture {
                                        selectedCoverName = coverName
                                        showCoverFullScreen = true
                                    }
                            } else {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 50, height: 75)
                                    .cornerRadius(4)
                            }
                            
                            NavigationLink(destination: BookDetailView(book: book)) {
                                Text(book.title ?? "Brak tytułu")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .onDelete(perform: deleteBooks)
                    .onMove(perform: moveBooks)
                }
            }
            .navigationTitle("Moja biblioteczka")
            .toolbar {
                EditButton()
            }
            .sheet(isPresented: $showCoverFullScreen) {
                if let cover = selectedCoverName {
                    ZStack(alignment: .topTrailing) {
                        Color.black.ignoresSafeArea()
                        Image(cover)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .background(Color.black)
                            .onTapGesture {
                                showCoverFullScreen = false
                            }
                        Button(action: { showCoverFullScreen = false }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                }
            }
        }
    }
    
    // Usuń książkę z ulubionych i Core Data
    func deleteBooks(at offsets: IndexSet) {
        guard let user = currentUser else { return }
        var booksArray = favoriteBooks
        
        offsets.forEach { index in
            let bookToRemove = booksArray[index]
            user.mutableSetValue(forKey: "toBook").remove(bookToRemove)
            viewContext.delete(bookToRemove)
        }
        
        saveContext()
    }
    
    // Przesuń książkę i aktualizuj atrybut order
    func moveBooks(from source: IndexSet, to destination: Int) {
        guard let user = currentUser else { return }
        // Pobierz posortowane książki
        var booksArray = (user.toBook as? Set<Book>)?.sorted(by: { $0.order < $1.order }) ?? []
        
        // Przesuń elementy
        booksArray.move(fromOffsets: source, toOffset: destination)
        
        // Zaktualizuj order według nowej kolejności
        for (index, book) in booksArray.enumerated() {
            book.order = Int64(index)
        }
        
        saveContext()
    }

    
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Błąd zapisu Core Data: \(error.localizedDescription)")
        }
    }
}
