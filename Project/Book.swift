//
//  Book.swift
//  projekt_swift
//
//  Created by Agnieszka Marzeda on 04/04/2025.
//

import Foundation

struct Book: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var genre: String
    var description: String
    var coverImage: String
}

let books = [
    Book(title: "Mały Książę",
         author: "Antoine de Saint-Exupéry",
         genre: "Literatura piękna",
         description: "Poetycka opowieść o miłości, przyjaźni i odpowiedzialności Antoine'a de Saint-Exupéry'ego została przetłumaczone na ponad 270 języków i należy do klasyki literatury światowej. Historia wrażliwego złotowłosego chłopca, wzbogacona pięknymi ilustracjami autora, od lat wzrusza dzieci i dorosłych na całym świecie.",
         coverImage: "malyKsiaze"),
    
    Book(title: "1984",
         author: "George Orwell",
         genre: "Dystopia",
         description: "Wielka powieść dystopijna, która ukazuje totalitarne społeczeństwo, w którym panuje absolutna kontrola nad obywatelami. Orwell stworzył obraz przerażającego świata, w którym państwo ma pełną kontrolę nad myślami i działaniami jednostki.",
         coverImage: "1984"),
    
    Book(title: "Zbrodnia i kara",
         author: "Fiodor Dostojewski",
         genre: "Literatura klasyczna",
         description: "Dzieło, które opowiada historię młodego studenta, Rodiona Raskolnikowa, który dokonuje morderstwa i zmaga się z moralnymi i psychologicznymi konsekwencjami swojego czynu.",
         coverImage: "zbrodnia_i_kara"),
    
    Book(title: "Mistrz i Małgorzata",
         author: "Michaił Bułhakow",
         genre: "Powieść filozoficzna",
         description: "Mistrz i Małgorzata to jedno z najwybitniejszych dzieł literatury XX wieku, łączące realizm, fantastykę i filozofię. Historia Mistrza, pisarza, który kochał Małgorzatę, a także wątek diabła, który przybywa do Moskwy.",
         coverImage: "mistrz_i_malgorzata"),
    
    Book(title: "Rok 1984",
         author: "George Orwell",
         genre: "Dystopia",
         description: "Kultowa powieść Orwella, która ukazuje totalitarny świat, w którym rządzący reżim kontroluje każdą sferę życia obywateli, w tym ich myśli i uczucia. Książka ostrzega przed zagrożeniami wynikającymi z absolutnej władzy.",
         coverImage: "rok_1984"),
    
    Book(title: "Harry Potter i Kamień Filozoficzny",
         author: "J.K. Rowling",
         genre: "Fantasy",
         description: "Pierwsza książka z serii o Harrym Potterze. Młody czarodziej Harry dowiaduje się, że jest jednym z wybrańców, a jego przeznaczeniem jest stawić czoła największemu złu świata czarodziejów.",
         coverImage: "harry_potter"),
    
    Book(title: "Władca Pierścieni: Drużyna Pierścienia",
         author: "J.R.R. Tolkien",
         genre: "Fantasy",
         description: "Pierwsza część kultowej trylogii Tolkiena. W książce śledzimy podróż Froda Bagginsa, który wyrusza na niebezpieczną misję, aby zniszczyć Pierścień Władzy.",
         coverImage: "wladca_pierscieni"),
    
    Book(title: "Sto lat samotności",
         author: "Gabriel García Márquez",
         genre: "Magiczny realizm",
         description: "Jedno z najważniejszych dzieł literatury latynoamerykańskiej. Powieść opowiada historię rodziny Buendía, której losy splatają się z historią Kolumbii. To opowieść o miłości, wojnach, polityce i magii.",
         coverImage: "sto_lat_samotnosci"),
    
    Book(title: "Przeminęło z wiatrem",
         author: "Margaret Mitchell",
         genre: "Powieść historyczna",
         description: "Opowieść o miłości Scarlett O'Hary i Rhetta Butlera na tle amerykańskiej wojny secesyjnej. Książka jest jednym z największych klasyków literatury amerykańskiej.",
         coverImage: "przeminelo_z_wiatrem"),
    
    Book(title: "Zabić drozda",
         author: "Harper Lee",
         genre: "Powieść społeczna",
         description: "Historia opowiedziana oczami małej dziewczynki, Scout Finch, o jej ojcu, który broni niewinnego mężczyzny oskarżonego o gwałt. Powieść porusza kwestie rasizmu, sprawiedliwości i dorastania.",
         coverImage: "zabic_drozda"),
    
    Book(title: "Moby Dick",
         author: "Herman Melville",
         genre: "Przygodowa",
         description: "Klasyka literatury amerykańskiej, opowiadająca o obsesji kapitana Ahaba, który prowadzi swoją załogę na pościg za wielkim białym wielorybem, Moby Dickiem.",
         coverImage: "moby_dick"),
    
    Book(title: "Czarnobylska modlitwa",
         author: "Swietłana Aleksijewicz",
         genre: "Reportaż",
         description: "Książka opowiada o tragedii mieszkańców Prypeci i okolicznych wiosek po katastrofie w Czarnobylu. Aleksijewicz zbiera świadectwa tych, którzy przeżyli i musieli zmierzyć się z konsekwencjami tej strasznej tragedii.",
         coverImage: "czarnobylska_modlitwa"),
    
    Book(title: "Pani Bovary",
         author: "Gustave Flaubert",
         genre: "Powieść psychologiczna",
         description: "Książka opowiada historię Emmy Bovary, której życie pełne jest marzeń o miłości i luksusie, a jednocześnie zmaga się z pułapką życia na prowincji.",
         coverImage: "pani_bovary"),
    
    Book(title: "Frankenstein",
         author: "Mary Shelley",
         genre: "Horror",
         description: "Opowieść o młodym naukowcu Victorze Frankensteinie, który tworzy potwora z martwych ciał. Książka bada granice ludzkiej ambicji i cenę, jaką za nią płaci.",
         coverImage: "frankenstein")
]
