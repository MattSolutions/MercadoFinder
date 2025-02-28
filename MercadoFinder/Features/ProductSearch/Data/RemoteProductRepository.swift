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
        Logger.info("Searching products with query: \(query)")
        do {
            let endpoint = ProductEndpoints.searchProducts(productName: query)
            return try await apiClient.fetch(endpoint)
        } catch {
            Logger.error("Failed to search products: \(error)")
            throw error
        }
    }
    
    func getProductDetail(id: String) async throws -> Product {
        Logger.info("Getting product detail for ID: \(id)")
        do {
            let endpoint = ProductEndpoints.productDetail(productId: id)
            return try await apiClient.fetch(endpoint)
        } catch {
            Logger.error("Failed to get product detail: \(error)")
            throw error
        }
    }
}
