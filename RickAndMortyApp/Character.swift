//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Ernesto Ovalle on 24/02/26.
//

import Foundation

struct CharactersResponse: Decodable {
    let results: [Character]
}

struct Character: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let origin: NameContainer
    let location: NameContainer
}

struct NameContainer: Decodable {
    let name: String
}
