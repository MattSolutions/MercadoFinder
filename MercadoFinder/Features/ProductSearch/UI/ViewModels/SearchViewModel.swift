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
    case failure(Error, retry: (() -> Void)?)
}


@MainActor
final class SearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var state: SearchState = .empty
    
    private let searchUseCase: SearchProductsUseCaseProtocol
    
    init(searchUseCase: SearchProductsUseCaseProtocol = SearchProductsUseCase()) {
        self.searchUseCase = searchUseCase
    }
    
    func search() async {
        guard !searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            state = .empty
            return
        }
        
        state = .loading
        
        do {
            let result = try await searchUseCase.execute(query: searchQuery)
            state = .success(result.results)
        } catch {
            let networkError = error as? NetworkError ?? NetworkError.unknown
            state = .failure(networkError) { [weak self] in
                Task { await self?.search() }
            }
            Logger.error("Search error: \(error)")
        }
    }
}


