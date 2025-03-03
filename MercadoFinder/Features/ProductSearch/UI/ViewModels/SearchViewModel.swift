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
        if searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            clearSearch()
            return
        }
        performSearch()
    }
    
    func clearSearch() {
        searchQuery = ""
        state = .empty
    }
    
    // MARK: - Private Methods
    private func performSearch() {
        state = .loading
        
        Task {
            do {
                let result = try await searchUseCase.execute(query: searchQuery)
                state = .success(result.results)
            } catch {
                let networkError = error as? NetworkError ?? NetworkError.unknown
                state = .failure(networkError, retryAction: performSearch)
                Logger.error("Search error: \(error)")
            }
        }
    }
}
