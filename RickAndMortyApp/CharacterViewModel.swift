//
//  CharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by Ernesto Ovalle on 24/02/26.
//

import Foundation
import Observation

@MainActor
@Observable
class CharacterViewModel {

    var characters: [Character] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil

    private let listURL = "https://rickandmortyapi.com/api/character"

    func getCharacters() async {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: listURL) else {
            isLoading = false
            errorMessage = "Invalid URL."
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let http = response as? HTTPURLResponse else {
                isLoading = false
                errorMessage = "Invalid response."
                return
            }

            guard (200...299).contains(http.statusCode) else {
                isLoading = false
                errorMessage = "Request failed (HTTP \(http.statusCode))."
                return
            }

            let decoded = try JSONDecoder().decode(CharactersResponse.self, from: data)
            self.characters = decoded.results

        } catch let urlError as URLError where urlError.code == .notConnectedToInternet {
            // Requirement e: friendly offline message
            errorMessage = "No connection. Please try again."
        } catch {
            errorMessage = "Unexpected error: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
