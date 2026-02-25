# RickAndMortyApp

SwiftUI app that consumes a real public API and displays data using MVVM architecture.

## API Used

GET endpoint:
https://rickandmortyapi.com/api/character

## Features

- Fetches real-time data from a public API
- Displays characters in a List
- NavigationStack with detail view
- Loading state using ProgressView
- Error handling (offline + HTTP status)
- Pull to refresh
- Clean Code principles applied

## Architecture

This project follows the MVVM pattern:

- Model: Character.swift
- ViewModel: CharacterViewModel.swift
- Views: CharacterListView + CharacterDetailView

## Error Handling

- Shows friendly message when offline
- Displays HTTP errors
- Prevents crashes from invalid responses

## Technologies

- SwiftUI
- URLSession
- Async/Await
- MVVM
- Network framework (offline detection)

---

Developed for API Activity Assignment.
