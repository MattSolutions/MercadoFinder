//
//  SearchProductsUseCase.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation

protocol SearchProductsUseCaseProtocol {
    func execute(query: String) async throws -> SearchResult
}

final class SearchProductsUseCase: SearchProductsUseCaseProtocol {
    private let repository: ProductRepositoryProtocol

    init(repository: ProductRepositoryProtocol = RemoteProductRepository()) {
        self.repository = repository
    }

    func execute(query: String) async throws -> SearchResult {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            Logger.error("Empty search query")
            throw NetworkError.invalidURL
        }

        return try await repository.searchProducts(query: query)
    }
}
