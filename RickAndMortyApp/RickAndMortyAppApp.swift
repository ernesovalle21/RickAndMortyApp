//
//  RickAndMortyAppApp.swift
//  RickAndMortyApp
//
//  Created by Ernesto Ovalle on 24/02/26.
//

import SwiftUI

@main
struct RickAndMortyAppApp: App {
    var body: some Scene {
        WindowGroup {
            CharacterListView()
                .preferredColorScheme(.dark)
        }
    }
}
