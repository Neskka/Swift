//
//  SampleData.swift
//  LibraryProject
//
//  Created by Agnieszka Marzeda on 11/05/2025.
//

import Foundation
import CoreData

func preloadSampleBooks(context: NSManagedObjectContext) {
    let request: NSFetchRequest<Book> = Book.fetchRequest()
    request.fetchLimit = 1

    // Dodawaj tylko przy pierwszym uruchomieniu
    if let count = try? context.count(for: request), count > 0 {
        return
    }

    let sampleBooks: [(String, String, String, String, String, Double)] = [
        ("Harry Potter", "J.K. Rowling", "Fantasy", "cover1", "Magiczna opowieść o młodym czarodzieju.", 39.99),
        ("Rok 1984", "George Orwell", "Dystopia", "cover2", "Wizja totalitarnego państwa przyszłości.", 29.99),
        ("Fundacja", "Isaac Asimov", "Sci-Fi", "cover3", "Klasyka literatury science fiction.", 34.50),
        ("Władca Pierścieni", "J.R.R. Tolkien", "Fantasy", "cover4", "Epicka podróż przez Śródziemie.", 49.90),
        ("Zbrodnia i kara", "Fiodor Dostojewski", "Powieść psychologiczna", "cover5", "Psychologiczny dramat z rosyjskim klimatem.", 44.00),
        ("Igrzyska Śmierci", "Suzanne Collins", "Thriller", "cover6", "Walka na śmierć i życie w dystopijnym świecie.", 34.99),
        ("Lśnienie", "Stephen King", "Thriller", "cover7", "Klasyczny horror w opuszczonym hotelu.", 38.00),
        ("Sto lat samotności", "Gabriel García Márquez", "Literatura piękna", "cover8", "Magiczny realizm w najlepszym wydaniu.", 46.00),
        ("Filary Ziemi", "Ken Follett", "Powieść historyczna", "cover9", "Historia budowy katedry i ludzkich dramatów.", 52.90),
        ("20 000 mil podmorskiej żeglugi", "Jules Verne", "Przygodowa", "cover10", "Podróż z Kapitanem Nemo.", 28.90),
        ("Kafka nad morzem", "Haruki Murakami", "Literatura piękna", "cover11", "Surrealistyczna podróż przez Japonię.", 44.99),
        ("Wichrowe Wzgórza", "Emily Brontë", "Romance", "cover12", "Miłość i zemsta na wrzosowiskach.", 24.99),
        ("Z zimną krwią", "Truman Capote", "Reportaż", "cover13", "Zbrodnia opisana jak powieść.", 38.50),
        ("Opowieść podręcznej", "Margaret Atwood", "Dystopia", "cover14", "Społeczeństwo bez wolności kobiet.", 33.90),
        ("Stary człowiek i morze", "Ernest Hemingway", "Literatura piękna", "cover15", "Walka człowieka z naturą.", 22.99)
    ]

    for (title, author, category, cover, desc, price) in sampleBooks {
        let book = Book(context: context)
        book.id = UUID()
        book.title = title
        book.author = author
        book.category = category
        book.cover = cover
        book.descriptionText = desc
        book.price = price
    }

    do {
        try context.save()
    } catch {
        print("Błąd zapisu danych: \(error)")
    }
}
