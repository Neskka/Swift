//
//  BookstoreView.swift
//  Project
//
//  Created by Agnieszka Marzeda on 11/04/2025.
//

import SwiftUI
import MapKit

struct BookstoreView: View {
    let bookstore: Bookstore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(bookstore.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                HStack(spacing: 4) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < Int(bookstore.rating.rounded()) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                    }
                    Text("(\(String(format: "%.1f", bookstore.rating)))")
                        .foregroundColor(.gray)
                }

                Text(bookstore.description)
                    .font(.body)

                if bookstore.hasApp {
                    HStack {
                        Image(systemName: "app.fill")
                            .foregroundColor(.purple)
                        Text("Ta księgarnia posiada aplikację mobilną")
                            .foregroundColor(.purple)
                    }
                    .font(.subheadline)
                }

                // Mini mapa z lokalizacją księgarni
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: bookstore.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )), annotationItems: [bookstore]) { location in
                    MapMarker(coordinate: location.coordinate, tint: .purple)
                }
                .frame(height: 200)
                .cornerRadius(12)
            }
            .padding()
        }
        .navigationTitle("Szczegóły")
        .navigationBarTitleDisplayMode(.inline)
    }
}
