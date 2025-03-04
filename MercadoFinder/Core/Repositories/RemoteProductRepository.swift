//
//  RemoteProductRepository.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation

final class RemoteProductRepository: ProductRepositoryProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func searchProducts(query: String) async throws -> SearchResult {
        let endpoint = ProductEndpoints.searchProducts(productName: query)
        return try await apiClient.fetch(endpoint)
    }

    func getProductDetail(id: String) async throws -> Product {
        let endpoint = ProductEndpoints.productDetail(productId: id)
        return try await apiClient.fetch(endpoint)
    }
}
