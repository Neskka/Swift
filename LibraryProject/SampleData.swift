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

    // Format: (title, author, category, cover, description, price, isbn, publisher, releaseDateStr, pageCount, rating, readingTimeText)
    let sampleBooks: [(String, String, String, String, String, Double, String, String, String, Int64, Double, String)] = [
        (
            "Harry Potter i kamień filozoficzny",
            "J.K. Rowling",
            "Fantasy",
            "harryPotter",
            """
            Pierwsza część kultowej sagi o młodym czarodzieju, który odkrywa swoje magiczne dziedzictwo i rozpoczyna naukę w Szkole Magii i Czarodziejstwa w Hogwarcie. Harry poznaje nowych przyjaciół, staje w obliczu niebezpieczeństw, odkrywa tajemnice swojej przeszłości i zmierza się z siłami zła, które czyhają na kamień filozoficzny. Książka pełna magii, przygód i uniwersalnych wartości takich jak odwaga i przyjaźń.
            """,
            39.99,
            "978-0-7475-3269-9",
            "Media Rodzina",
            "1997-06-26",
            223,
            4.7,
            "8 godzin 30 minut"
        ),
        (
            "Rok 1984",
            "George Orwell",
            "Dystopia",
            "1984",
            """
            Przerażająca wizja totalitarnego społeczeństwa, w którym Wielki Brat nieustannie monitoruje obywateli, a prawda jest manipulowana na potrzeby władzy. Główny bohater Winston Smith podejmuje próbę buntu wobec opresyjnego reżimu, co prowadzi go do dramatycznych konsekwencji. To ponadczasowa przestroga przed niebezpieczeństwem utraty wolności i manipulacji politycznej.
            """,
            29.99,
            "978-0-452-28423-4",
            "Czytelnik",
            "1949-06-08",
            328,
            4.4,
            "7 godzin 15 minut"
        ),
        (
            "Fundacja",
            "Isaac Asimov",
            "Sci-Fi",
            "fundacja",
            """
            Początek legendarnej serii science fiction opowiadającej o przyszłości, w której nauka psychohistorii pozwala przewidywać losy galaktycznego Imperium. Hari Seldon zakłada Fundację — instytucję mającą ocalić wiedzę i cywilizację przed nieuchronnym upadkiem. Książka łączy elementy polityki, matematyki i przygody w fascynującej opowieści o przetrwaniu i nadziei.
            """,
            34.50,
            "978-0-553-80371-0",
            "Prószyński i S-ka",
            "1951-05-01",
            255,
            4.5,
            "6 godzin 40 minut"
        ),
        (
            "Władca Pierścieni",
            "J.R.R. Tolkien",
            "Fantasy",
            "wladcaPierscieni",
            """
            Epicka saga o walce dobra ze złem w mistycznym Śródziemiu. Drużyna bohaterów wyrusza na niebezpieczną misję zniszczenia Pierścienia Władzy, aby zapobiec powrotowi mrocznego Saurona do władzy. Pełna przepięknych opisów, bogatej mitologii i głębokich przesłań o przyjaźni, poświęceniu i nadziei.
            """,
            49.90,
            "978-0-618-00222-8",
            "Rebis",
            "1954-07-29",
            1178,
            4.9,
            "32 godziny 0 minut"
        ),
        (
            "Zbrodnia i kara",
            "Fiodor Dostojewski",
            "Powieść psychologiczna",
            "zbrodniaIKara",
            """
            Przenikliwa analiza psychiki młodego studenta Rodiona Raskolnikowa, który dokonuje morderstwa z przekonania o własnej wyjątkowości. Książka eksploruje moralne dylematy, wyrzuty sumienia i poszukiwanie odkupienia, tworząc jeden z najważniejszych dramatów literatury światowej.
            """,
            44.00,
            "978-0-679-42365-6",
            "Czytelnik",
            "1866-01-01",
            671,
            4.6,
            "19 godzin 45 minut"
        ),
        (
            "Igrzyska Śmierci",
            "Suzanne Collins",
            "Thriller",
            "igrzyskaSmierci",
            """
            W dystopijnym świecie Panem młodzi są zmuszani do brutalnej walki na śmierć i życie w widowiskowym reality show. Katniss Everdeen, główna bohaterka, staje się symbolem oporu i nadziei na zmianę w okrutnym systemie. Pełna napięcia powieść o przetrwaniu, lojalności i walce o wolność.
            """,
            34.99,
            "978-0-439-02352-8",
            "Media Rodzina",
            "2008-09-14",
            374,
            4.3,
            "10 godzin 20 minut"
        ),
        (
            "Lśnienie",
            "Stephen King",
            "Thriller",
            "lsnienie",
            """
            Jack Torrance, pisarz zmagający się z demonami przeszłości, podejmuje pracę dozorcy w odizolowanym hotelu Overlook. Mroczne siły obecne w budynku zaczynają wpływać na jego psychikę, prowadząc do przerażającego szaleństwa. Książka pełna napięcia i grozy, klasyk literatury horroru.
            """,
            38.00,
            "978-0-385-12167-5",
            "Prószyński i S-ka",
            "1977-01-28",
            659,
            4.2,
            "18 godzin 0 minut"
        ),
        (
            "Sto lat samotności",
            "Gabriel García Márquez",
            "Literatura piękna",
            "stoLatSamotnosci",
            """
            Historia rodziny Buendía, której losy splatają się z magią, polityką i historią miasteczka Macondo. Arcydzieło realizmu magicznego pełne metafor, symboli i poruszających momentów. Książka ukazuje ludzkie namiętności, powtarzające się błędy i próbę odnalezienia sensu życia.
            """,
            46.00,
            "978-0-06-088328-7",
            "Wydawnictwo Literackie",
            "1967-05-30",
            417,
            4.7,
            "12 godzin 30 minut"
        ),
        (
            "Filary Ziemi",
            "Ken Follett",
            "Powieść historyczna",
            "filaryZiemi",
            """
            Opowieść o budowie katedry w średniowiecznej Anglii, która łączy w sobie politykę, miłość, zdradę i wiarę. Książka przedstawia złożone losy bohaterów i społeczeństwa, ukazując potęgę marzeń i determinacji w obliczu trudności.
            """,
            52.90,
            "978-0-451-21865-9",
            "Albatros",
            "1989-09-01",
            973,
            4.5,
            "29 godzin 15 minut"
        ),
        (
            "20 000 mil podmorskiej żeglugi",
            "Jules Verne",
            "Przygodowa",
            "20000mil",
            """
            Kapitan Nemo zabiera grupę naukowców na niesamowitą podróż podwodnym okrętem Nautilus po oceanicznych głębinach. Książka pełna niezwykłych odkryć, przygód i tajemnic, które rozbudzają wyobraźnię czytelników w każdym wieku.
            """,
            28.90,
            "978-0-553-21247-5",
            "Nasza Księgarnia",
            "1870-06-20",
            320,
            4.1,
            "8 godzin 50 minut"
        ),
        (
            "Kafka nad morzem",
            "Haruki Murakami",
            "Literatura piękna",
            "kafkaNadMorzem",
            """
            Dwutorowa, surrealistyczna opowieść o losach nastoletniego chłopca i starszego mężczyzny, których drogi splatają się w magicznym świecie pełnym symboliki i tajemnic. Książka eksploruje motywy przeznaczenia, samotności i poszukiwania własnej tożsamości.
            """,
            44.99,
            "978-0-09-945832-6",
            "Wydawnictwo Literackie",
            "2002-09-12",
            505,
            4.3,
            "14 godzin 0 minut"
        ),
        (
            "Wichrowe Wzgórza",
            "Emily Brontë",
            "Romans",
            "wichroweWzgorza",
            """
            Mroczna i pełna namiętności historia miłości, nienawiści i zemsty na angielskich wrzosowiskach. Klasyka literatury gotyckiej i romantycznej, która wciąga czytelnika w świat skomplikowanych emocji i tragicznych losów bohaterów.
            """,
            24.99,
            "978-0-14-143955-6",
            "Znak",
            "1847-12-01",
            416,
            4.0,
            "12 godzin 20 minut"
        ),
        (
            "Z zimną krwią",
            "Truman Capote",
            "Reportaż",
            "zZimnaKrwia",
            """
            Dokumentalna opowieść o brutalnym morderstwie w małym miasteczku w Kansas oraz o procesie jego sprawców. Capote łączy rzetelne dziennikarstwo z narracją literacką, tworząc poruszający portret zbrodni i jej wpływu na społeczność.
            """,
            38.50,
            "978-0-679-74558-1",
            "Wydawnictwo Literackie",
            "1966-01-17",
            343,
            4.4,
            "10 godzin 15 minut"
        ),
        (
            "Opowieść podręcznej",
            "Margaret Atwood",
            "Dystopia",
            "opowiescPodrecznej",
            """
            W totalitarnym państwie Gilead kobiety tracą wszystkie prawa i są traktowane jako własność państwa. Główna bohaterka, Podręczna, walczy o przetrwanie i zachowanie resztek człowieczeństwa w świecie pełnym opresji i przemocy. Poruszająca i przerażająca wizja przyszłości.
            """,
            33.90,
            "978-0-385-49081-9",
            "W.A.B.",
            "1985-08-17",
            311,
            4.2,
            "9 godzin 45 minut"
        ),
        (
            "Stary człowiek i morze",
            "Ernest Hemingway",
            "Literatura piękna",
            "staryCzlowiekIMorze",
            """
            Historia starego rybaka Santiago, który wyrusza samotnie na morze, by zmierzyć się potężnym marlina. To opowieść o walce, wytrwałości, honorze i ludzkim duchu, napisana w prostym, a jednocześnie głębokim stylu.
            """,
            22.99,
            "978-0-684-80122-3",
            "Czytelnik",
            "1952-09-01",
            127,
            4.3,
            "4 godziny 50 minut"
        )
    ]

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    for (title, author, category, cover, desc, price, isbn, publisher, releaseDateStr, pageCount, rating, readingTime) in sampleBooks {
        let book = Book(context: context)
        book.id = UUID()
        book.title = title
        book.author = author
        book.category = category
        book.cover = cover
        book.descriptionText = desc
        book.price = price
        book.isbn = isbn
        book.publisher = publisher
        book.releaseDate = dateFormatter.date(from: releaseDateStr)
        book.pageCount = pageCount
        book.rating = rating
        book.readingTime = readingTime
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
