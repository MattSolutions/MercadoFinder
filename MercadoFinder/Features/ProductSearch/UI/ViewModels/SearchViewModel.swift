//
//  SearchViewModel.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation
import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var searchResults: [Product] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let searchUseCase: SearchProductsUseCaseProtocol
    
    init(searchUseCase: SearchProductsUseCaseProtocol = SearchProductsUseCase()) {
        self.searchUseCase = searchUseCase
    }
    
    @MainActor
    func search() async {
        guard !searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        error = nil
        searchResults = []
        
        do {
            let result = try await searchUseCase.execute(query: searchQuery)
            guard !result.results.isEmpty else {
                throw ProductError.noResults  
            }
            searchResults = result.results
        } catch {
            self.error = error
            Logger.error("Search error: \(error)")
        }
    }
}

