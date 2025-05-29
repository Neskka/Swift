import SwiftUI
import MapKit
import CoreData

struct MapView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Bookstore.entity(), sortDescriptors: []) private var bookstores: FetchedResults<Bookstore>

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.2297, longitude: 21.0122),
        span: MKCoordinateSpan(latitudeDelta: 4.0, longitudeDelta: 4.0)
    )
    
    @State private var selectedBookstore: Bookstore? = nil
    @State private var selectedCity: String = "Warszawa"
    
    let cities = ["Warszawa", "Kraków", "Wrocław", "Poznań", "Lublin"]

    func updateMap(for city: String) {
        switch city {
        case "Warszawa":
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.2297, longitude: 21.0122), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        case "Kraków":
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.0647, longitude: 19.9450), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        case "Wrocław":
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.1079, longitude: 17.0385), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        case "Poznań":
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.4064, longitude: 16.9252), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        case "Lublin":
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.2465, longitude: 22.5684), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        default:
            break
        }
    }

    var filteredBookstores: [Bookstore] {
        bookstores.filter { store in
            switch selectedCity {
            case "Warszawa":
                return abs(store.latitude - 52.2297) < 0.01 && abs(store.longitude - 21.0122) < 0.01
            case "Kraków":
                return abs(store.latitude - 50.0647) < 0.01 && abs(store.longitude - 19.9450) < 0.01
            case "Wrocław":
                return abs(store.latitude - 51.1079) < 0.01 && abs(store.longitude - 17.0385) < 0.01
            case "Poznań":
                return abs(store.latitude - 52.4064) < 0.01 && abs(store.longitude - 16.9252) < 0.01
            case "Lublin":
                return abs(store.latitude - 51.2465) < 0.01 && abs(store.longitude - 22.5684) < 0.01
            default:
                return false
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Map(coordinateRegion: $region, annotationItems: filteredBookstores) { bookstore in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: bookstore.latitude, longitude: bookstore.longitude)) {
                        Button {
                            selectedBookstore = bookstore
                        } label: {
                            VStack(spacing: 4) {
                                Text(bookstore.name ?? "Brak nazwy")
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)  // <--- WAŻNE

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
                        BookstoreView(bookstore: bookstore, dismissAction: {
                            selectedBookstore = nil
                        })
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: selectedBookstore)
                    }
                }
            }
        }
    }
}

#Preview {
    MapView()
}
