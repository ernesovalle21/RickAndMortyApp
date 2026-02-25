//
//  CharacterListView.swift
//  RickAndMortyApp
//
//  Created by Ernesto Ovalle on 24/02/26.
//

import SwiftUI

struct CharacterListView: View {

    @State var vm = CharacterViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if vm.isLoading {
                    ProgressView("Loading characters...")
                        .padding()
                } else if let msg = vm.errorMessage {
                    ErrorView(message: msg) {
                        Task { await vm.getCharacters() }
                    }
                    .padding()
                } else {
                    List(vm.characters) { character in
                        NavigationLink {
                            CharacterDetailView(character: character)
                        } label: {
                            HStack(spacing: 12) {

                                AsyncImage(url: URL(string: character.image)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 60, height: 60)
                                    case .success(let img):
                                        img.resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    case .failure:
                                        Image(systemName: "photo")
                                            .frame(width: 60, height: 60)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(character.name)
                                        .font(.headline)
                                        .foregroundStyle(.white)

                                    Text("\(character.species) • \(character.status)")
                                        .font(.subheadline)
                                        .foregroundStyle(.gray)
                                }
                            }
                            .padding(.vertical, 6)
                        }
                        .listRowBackground(Color.black.opacity(0.85))
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.black)
                }
            }
            .navigationTitle("Characters")
            .task {
                await vm.getCharacters()
            }
            .refreshable {
                await vm.getCharacters()
            }
        }
    }
}

private struct CharacterRowView: View {
    let character: Character

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: character.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 56, height: 56)
                case .success(let img):
                    img.resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                case .failure:
                    Image(systemName: "photo")
                        .frame(width: 56, height: 56)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.headline)
                Text("\(character.species) • \(character.status)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 6)
    }
}

private struct ErrorView: View {
    let message: String
    let retry: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 34))
                .foregroundStyle(.secondary)

            Text(message)
                .multilineTextAlignment(.center)

            Button("Retry", action: retry)
                .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: 420)
    }
}

#Preview {
    CharacterListView()
}
