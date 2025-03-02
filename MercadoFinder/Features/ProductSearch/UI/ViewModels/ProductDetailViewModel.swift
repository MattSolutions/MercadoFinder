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
    case error(Error, (() -> Void)?)
}

final class ProductDetailViewModel: ObservableObject {
    @Published var state: ProductDetailState = .loading
    @Published var showErrorAlert = false
    
    var error: Error? = nil
    private let productId: String
    private let getProductDetailUseCase: GetProductDetailUseCaseProtocol
    
    init(productId: String, getProductDetailUseCase: GetProductDetailUseCaseProtocol = GetProductDetailUseCase()) {
        self.productId = productId
        self.getProductDetailUseCase = getProductDetailUseCase
        
        Task { await fetchProductDetails() }
    }
    
    @MainActor
    func fetchProductDetails() async {
        state = .loading
        
        do {
            let product = try await getProductDetailUseCase.execute(id: productId)
            state = .loaded(product)
        } catch {
            if let networkError = error as? NetworkError {
                self.error = networkError
            } else {
                self.error = NetworkError.unknown
            }
            
            state = .error(error) { [weak self] in
                Task { [weak self] in
                    await self?.fetchProductDetails()
                }
            }
            showErrorAlert = true
        }
    }
    
    func getProductURL(_ productId: String?) -> URL? {
        guard let id = productId else { return nil }
        return URL(string: "https://www.mercadolibre.com/item/\(id)")
    }
}
