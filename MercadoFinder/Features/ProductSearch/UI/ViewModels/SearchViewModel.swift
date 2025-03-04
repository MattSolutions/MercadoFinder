//
//  SearchViewModel.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation
import SwiftUI

enum SearchState {
    case empty
    case loading
    case success([Product])
    case failure(Error, retryAction: (() -> Void)?)
}

@MainActor
final class SearchViewModel: ObservableObject {
    // MARK: - State Properties
    @Published private(set) var state: SearchState = .empty
    @Published var searchQuery = ""
    
    // MARK: - Private Properties
    private let searchUseCase: SearchProductsUseCaseProtocol
    
    // MARK: - Initialization
    init(searchUseCase: SearchProductsUseCaseProtocol = SearchProductsUseCase()) {
        self.searchUseCase = searchUseCase
    }
    
    // MARK: - Search Methods
    func search() {
        let trimmedQuery = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        Logger.info("Search requested with query: '\(searchQuery)', trimmed: '\(trimmedQuery)'")
        
        if trimmedQuery.isEmpty {
            Logger.info("Empty search query, clearing results")
            clearSearch()
            return
        }
        performSearch()
    }

    func clearSearch() {
        Logger.info("Search cleared")
        searchQuery = ""
        state = .empty
    }
    
    // MARK: - Private Methods
    private func performSearch() {
        Logger.info("Performing search with query: '\(searchQuery)'")
        state = .loading
        
        Task {
            do {
                let result = try await searchUseCase.execute(query: searchQuery)
                Logger.info("Search successful: found \(result.results.count) results for '\(searchQuery)'")
                if result.results.isEmpty {
                    Logger.info("Search returned no results for query: '\(searchQuery)'")
                }
                state = .success(result.results)
            } catch {
                let networkError = error as? NetworkError ?? NetworkError.unknown
                Logger.error("Search failed: \(networkError.localizedDescription) for query: '\(searchQuery)'")
                state = .failure(networkError, retryAction: performSearch)
            }
        }
    }
}
