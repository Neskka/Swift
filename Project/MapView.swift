//
//  MapView.swift
//  Lab6_EM
//
//  Created by student on 10/04/2025.
//

import SwiftUI
import MapKit

// MARK: - Model księgarni
struct Bookstore: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let rating: Double
    let description: String
    let hasApp: Bool

    static func ==(lhs: Bookstore, rhs: Bookstore) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Przykładowe dane księgarni
let allBookstores: [Bookstore] = [
    Bookstore(name: "Empik Warszawa", coordinate: CLLocationCoordinate2D(latitude: 52.2297, longitude: 21.0122), rating: 4.5, description: "Największa sieć księgarni w Polsce z szerokim wyborem książek, filmów i muzyki.", hasApp: true),
    Bookstore(name: "Księgarnia Kraków", coordinate: CLLocationCoordinate2D(latitude: 50.0647, longitude: 19.9450), rating: 4.2, description: "Lokalna księgarnia z wyjątkowym klimatem i dobrym wyborem literatury polskiej.", hasApp: false),
    Bookstore(name: "TaniaKsiazka Wrocław", coordinate: CLLocationCoordinate2D(latitude: 51.1079, longitude: 17.0385), rating: 4.7, description: "Popularna księgarnia internetowa z opcją odbioru osobistego w punkcie.", hasApp: true),
    Bookstore(name: "Bookland Poznań", coordinate: CLLocationCoordinate2D(latitude: 52.4064, longitude: 16.9252), rating: 4.3, description: "Rodzinna księgarnia z szeroką ofertą książek i kawiarnią.", hasApp: false)
]

// MARK: - Widok MapView
struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.2297, longitude: 21.0122),
        span: MKCoordinateSpan(latitudeDelta: 4.0, longitudeDelta: 4.0)
    )
    
    @State private var selectedBookstore: Bookstore? = nil
    @State private var filteredBookstores: [Bookstore] = allBookstores
    @State private var selectedCity: String = "Warszawa"
    
    let cities = ["Warszawa", "Kraków", "Wrocław", "Poznań", "Lublin"]

    func updateMap(for city: String) {
        switch city {
        case "Warszawa":
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.2297, longitude: 21.0122), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            filteredBookstores = allBookstores.filter { $0.coordinate.latitude == 52.2297 && $0.coordinate.longitude == 21.0122 }
        case "Kraków":
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.0647, longitude: 19.9450), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            filteredBookstores = allBookstores.filter { $0.coordinate.latitude == 50.0647 && $0.coordinate.longitude == 19.9450 }
        case "Wrocław":
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.1079, longitude: 17.0385), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            filteredBookstores = allBookstores.filter { $0.coordinate.latitude == 51.1079 && $0.coordinate.longitude == 17.0385 }
        case "Poznań":
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.4064, longitude: 16.9252), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            filteredBookstores = allBookstores.filter { $0.coordinate.latitude == 52.4064 && $0.coordinate.longitude == 16.9252 }
        case "Lublin":
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.2465, longitude: 22.5684), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            filteredBookstores = []
        default:
            break
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Map(coordinateRegion: $region, annotationItems: filteredBookstores) { bookstore in
                    MapAnnotation(coordinate: bookstore.coordinate) {
                        Button(action: {
                            selectedBookstore = bookstore
                        }) {
                            VStack(spacing: 4) {
                                Text(bookstore.name)
                                    .font(.caption)
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(6)
                                    .background(Color.purple.opacity(0.8))
                                    .cornerRadius(10)

                                Image(systemName: "book.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.purple)
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("📍 Księgarnie w Polsce")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.top, 50)
                    
                    Picker("Wybierz miasto", selection: $selectedCity) {
                        ForEach(cities, id: \.self) { city in
                            Text(city).tag(city)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(8)
                    .background(Color.purple.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.bottom, 10)
                    .onChange(of: selectedCity) { newCity in
                        updateMap(for: newCity)
                    }

                    Spacer()
                }

                if let bookstore = selectedBookstore {
                    VStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text(bookstore.name)
                                    .font(.headline)
                                Spacer()
                                Button(action: {
                                    selectedBookstore = nil
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                }
                            }

                            HStack(spacing: 4) {
                                ForEach(0..<5) { index in
                                    Image(systemName: index < Int(bookstore.rating.rounded()) ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                }
                                Text("(\(String(format: "%.1f", bookstore.rating)))")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }

                            NavigationLink(destination: BookstoreView(bookstore: bookstore)) {
                                Text("Więcej o księgarni")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.purple)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .padding()
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: selectedBookstore)
                }
            }
        }
    }
}

// MARK: - Podgląd
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
