//
//  BackgroundView.swift
//  projekt_swift
//
//  Created by Agnieszka Marzeda on 04/04/2025.
//

import Foundation

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("background")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .overlay(
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 10)
            )
    }
}
