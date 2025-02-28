//
//  ProductDetailViewModel.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation
import SwiftUI

final class ProductDetailViewModel: ObservableObject {
    @Published var product: Product?
    @Published var isLoading = false
    @Published var error: Error?
    
    private let productDetailUseCase: GetProductDetailUseCaseProtocol
    
    init(productDetailUseCase: GetProductDetailUseCaseProtocol = GetProductDetailUseCase()) {
        self.productDetailUseCase = productDetailUseCase
    }
    
    @MainActor
    func loadProductDetail(id: String) async {
        isLoading = true
        defer { isLoading = false }
        
        error = nil
        
        do {
            product = try await productDetailUseCase.execute(id: id)
        } catch {
            self.error = error
            Logger.error("Product detail error: \(error)")
        }
    }
}
