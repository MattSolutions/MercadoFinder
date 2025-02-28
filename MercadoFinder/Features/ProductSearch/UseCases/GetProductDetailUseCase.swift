//
//  GetProductsDetailUseCase.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation

protocol GetProductDetailUseCaseProtocol {
    func execute(id: String) async throws -> Product
}

final class GetProductDetailUseCase: GetProductDetailUseCaseProtocol {
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol = RemoteProductRepository()) {
        self.repository = repository
    }
    
    func execute(id: String) async throws -> Product {
        guard !id.isEmpty else {
            Logger.error("Empty product ID")
            throw ProductError.invalidProductId
        }
        
        Logger.info("Fetching details for product: \(id)")
        return try await repository.getProductDetail(id: id)
    }
}
