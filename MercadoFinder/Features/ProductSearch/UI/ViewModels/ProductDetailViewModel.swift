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
    // MARK: - State
    @Published private(set) var state: ProductDetailState = .loading
    
    // MARK: - Private Properties
    private let productId: String
    private let getProductDetailUseCase: GetProductDetailUseCaseProtocol
    private var currentTask: Task<Void, Never>?
    
    // MARK: - Initialization
    init(
        productId: String,
        getProductDetailUseCase: GetProductDetailUseCaseProtocol = GetProductDetailUseCase()
    ) {
        self.productId = productId
        self.getProductDetailUseCase = getProductDetailUseCase
        fetchProductDetails()
    }
    
    deinit {
        currentTask?.cancel()
    }
    
    // MARK: - Fetch Data
    func fetchProductDetails() {
        currentTask?.cancel()
        
        state = .loading
        
        currentTask = Task {
            do {
                let product = try await getProductDetailUseCase.execute(id: productId)
                if !Task.isCancelled {
                    state = .loaded(product)
                }
            } catch {
                if !Task.isCancelled {
                    let networkError = error as? NetworkError ?? .unknown
                    state = .error(networkError, retryAction: fetchProductDetails)
                    Logger.error("Error fetching product details: \(networkError.localizedDescription)")
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
    
    func cancelOngoingTasks() {
        currentTask?.cancel()
        currentTask = nil
    }
}
