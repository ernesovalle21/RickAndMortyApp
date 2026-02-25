//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Ernesto Ovalle on 24/02/26.
//

import SwiftUI

struct CharacterDetailView: View {

    let character: Character

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                AsyncImage(url: URL(string: character.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 220)
                    case .success(let img):
                        img.resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, minHeight: 220)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                    case .failure:
                        Image(systemName: "photo")
                            .frame(maxWidth: .infinity, minHeight: 220)
                    @unknown default:
                        EmptyView()
                    }
                }

                Text(character.name)
                    .font(.title).bold()

                InfoCard(title: "Status", value: character.status)
                InfoCard(title: "Species", value: character.species)
                InfoCard(title: "Gender", value: character.gender)
                InfoCard(title: "Origin", value: character.origin.name)
                InfoCard(title: "Location", value: character.location.name)

            }
            .padding()
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct InfoCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title.uppercased())
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.body)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

