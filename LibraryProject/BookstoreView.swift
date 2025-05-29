import SwiftUI

struct BookstoreView: View {
    let bookstore: Bookstore
    let dismissAction: () -> Void

    var booksInStore: [Book] {
        let set = bookstore.books as? Set<Book> ?? []
        return Array(set)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(bookstore.name ?? "Brak nazwy")
                    .font(.title2)
                    .bold()
                Spacer()
                Button {
                    dismissAction()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }

            Text(bookstore.descriptionText ?? "")
                .font(.body)

            Text("Ocena: \(String(format: "%.1f", bookstore.rating)) ⭐️")
                .font(.headline)

            Divider()

            Text("Dostępne książki:")
                .font(.headline)

            List(booksInStore, id: \.self) { book in
                Text(book.title ?? "Brak tytułu")
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .padding()
    }
}
