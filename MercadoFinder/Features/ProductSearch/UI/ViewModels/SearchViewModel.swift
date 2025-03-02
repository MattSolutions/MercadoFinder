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

        error = nil
        
        guard !searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            searchResults = []
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        searchResults = []
        
        do {
            let result = try await searchUseCase.execute(query: searchQuery)
            searchResults = result.results
        } catch {
            self.error = error
            Logger.error("Search error: \(error)")
        }
    }
}

