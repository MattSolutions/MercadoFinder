//
//  ProductDetailViewModel.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 02/03/2025.
//

import Foundation
import SwiftUI

enum ProductDetailState {
    case loading
    case loaded(Product)
    case error(Error, retryAction: (() -> Void)?)
}

@MainActor
final class ProductDetailViewModel: ObservableObject {
    // MARK: - State Properties
    @Published private(set) var state: ProductDetailState = .loading
    
    // MARK: - Private Properties
    private let productId: String
    private let getProductDetailUseCase: GetProductDetailUseCaseProtocol
    
    // MARK: - Computed Properties
    var product: Product? {
        guard case .loaded(let product) = state else { return nil }
        return product
    }
    
    // MARK: - Initialization
    init(
        productId: String,
        getProductDetailUseCase: GetProductDetailUseCaseProtocol = GetProductDetailUseCase()
    ) {
        self.productId = productId
        self.getProductDetailUseCase = getProductDetailUseCase
        
        fetchProductDetails()
    }
    
    // MARK: - Data Fetching
    func fetchProductDetails() {
        state = .loading
        
        Task {
            do {
                let product = try await getProductDetailUseCase.execute(id: productId)
                state = .loaded(product)
            } catch {
                let networkError = error as? NetworkError ?? .unknown
                state = .error(networkError) { [weak self] in
                    self?.fetchProductDetails()
                }
            }
        }
    }
    
    // MARK: - Utility Methods
    func getProductURL() -> URL? {
        guard
            case .loaded(let product) = state,
            let permalink = product.permalink,
            let url = URL(string: permalink)
        else { return nil }
        
        return url
    }
}
