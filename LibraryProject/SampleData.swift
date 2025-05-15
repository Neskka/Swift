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

    if let count = try? context.count(for: request), count > 0 {
        return
    }

    let sampleBooks: [(String, String, String, String, String, Double, String)] = [
        ("Harry Potter i kamień filozoficzny", "J.K. Rowling", "Fantasy", "harryPotter", "Pierwsza część sagi o młodym czarodzieju, który dowiaduje się o swoim magicznym dziedzictwie i podejmuje naukę w Hogwarcie. Spotyka przyjaciół, rywalizuje z wrogami i odkrywa tajemnice przeszłości.", 39.99, "978-0-7475-3269-9"),
        ("Rok 1984", "George Orwell", "Dystopia", "1984", "Mroczna wizja przyszłości, w której wszechwładna partia sprawuje totalną kontrolę nad obywatelami, a każdy ruch obywatela jest śledzony przez Wielkiego Brata.", 29.99, "978-0-452-28423-4"),
        ("Fundacja", "Isaac Asimov", "Sci-Fi", "fundacja", "Początek kultowego cyklu science fiction o psychohistorii – nauce przewidującej przyszłość. Hari Seldon zakłada Fundację, by uratować wiedzę ludzkości przed upadkiem Imperium Galaktycznego.", 34.50, "978-0-553-80371-0"),
        ("Władca Pierścieni", "J.R.R. Tolkien", "Fantasy", "wladcaPierscieni", "Epicka opowieść o walce dobra ze złem w Śródziemiu. Grupa bohaterów wyrusza na misję zniszczenia Pierścienia Władzy, by pokonać Saurona.", 49.90, "978-0-618-00222-8"),
        ("Zbrodnia i kara", "Fiodor Dostojewski", "Powieść psychologiczna", "zbrodniaIKara", "Młody student Raskolnikow popełnia morderstwo w imię idei. Wstrząsająca analiza moralna i psychologiczna jego czynu i konsekwencji.", 44.00, "978-0-679-42365-6"),
        ("Igrzyska Śmierci", "Suzanne Collins", "Thriller", "igrzyskaSmierci", "W dystopijnym państwie Panem młodzi obywatele są zmuszeni do walki na śmierć i życie na oczach całego kraju. Katniss staje się symbolem buntu.", 34.99, "978-0-439-02352-8"),
        ("Lśnienie", "Stephen King", "Thriller", "lsnienie", "Jack Torrance podejmuje pracę dozorcy w odciętym od świata hotelu Overlook. Zło czające się w budynku powoli doprowadza go do obłędu.", 38.00, "978-0-385-12167-5"),
        ("Sto lat samotności", "Gabriel García Márquez", "Literatura piękna", "stoLatSamotnosci", "Saga rodu Buendía, których losy przeplatają się z magią, polityką i miłością. Klasyka realizmu magicznego, pełna symbolizmu i pięknych metafor.", 46.00, "978-0-06-088328-7"),
        ("Filary Ziemi", "Ken Follett", "Powieść historyczna", "filaryZiemi", "Powieść o budowie katedry w średniowiecznej Anglii, pełna intryg, pasji i konfliktów. Opowieść o determinacji, wierze i miłości.", 52.90, "978-0-451-21865-9"),
        ("20 000 mil podmorskiej żeglugi", "Jules Verne", "Przygodowa", "20000mil", "Kapitan Nemo zabiera grupę badaczy w podróż po oceanicznych głębinach na pokładzie Nautilusa. Fantastyczna przygoda pełna odkryć i zagadek.", 28.90, "978-0-553-21247-5"),
        ("Kafka nad morzem", "Haruki Murakami", "Literatura piękna", "kafkaNadMorzem", "Dwutorowa opowieść o nastolatku i starszym mężczyźnie, których losy splatają się w surrealistycznym świecie japońskiej symboliki.", 44.99, "978-0-09-945832-6"),
        ("Wichrowe Wzgórza", "Emily Brontë", "Romans", "wichroweWzgorza", "Burzliwa opowieść o miłości, nienawiści i zemście na angielskich wrzosowiskach. Klasyka literatury gotyckiej i romantycznej.", 24.99, "978-0-14-143955-6"),
        ("Z zimną krwią", "Truman Capote", "Reportaż", "zZimnaKrwia", "Dokumentalna opowieść o brutalnym morderstwie w Kansas i procesie sprawców. Łączy precyzyjne dziennikarstwo z narracją powieściową.", 38.50, "978-0-679-74558-1"),
        ("Opowieść podręcznej", "Margaret Atwood", "Dystopia", "opowiescPodrecznej", "W totalitarnym państwie Gilead kobiety tracą wszelkie prawa. Główna bohaterka, Podręczna, walczy o przetrwanie i wolność.", 33.90, "978-0-385-49081-9"),
        ("Stary człowiek i morze", "Ernest Hemingway", "Literatura piękna", "staryCzlowiekIMorze", "Historia starego rybaka Santiago, który wyrusza samotnie na morze, by zmierzyć się z gigantycznym marlina. Alegoria walki i honoru.", 22.99, "978-0-684-80122-3")
    ]

    for (title, author, category, cover, desc, price, isbn) in sampleBooks {
        let book = Book(context: context)
        book.id = UUID()
        book.title = title
        book.author = author
        book.category = category
        book.cover = cover
        book.descriptionText = desc
        book.price = price
        book.isbn = isbn
    }

    do {
        try context.save()
    } catch {
        print("Błąd zapisu danych: \(error)")
    }
}

func resetAllBooks(context: NSManagedObjectContext) {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Book.fetchRequest()
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    deleteRequest.resultType = .resultTypeObjectIDs

    do {
        let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
        if let objectIDs = result?.result as? [NSManagedObjectID] {
            let changes = [NSDeletedObjectsKey: objectIDs]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
        }
    } catch {
        print("Błąd podczas resetowania danych: \(error)")
    }
}

