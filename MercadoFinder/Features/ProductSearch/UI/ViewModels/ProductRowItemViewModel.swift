//
//  ProductListItemViewModel.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//


import Foundation
import SwiftUI

final class ProductRowItemViewModel: ObservableObject {
    private let product: Product
    
    @Published var title: String
    @Published var priceFormatted: String
    @Published var thumbnail: String?
    @Published var hasFreeShipping: Bool
    
    init(product: Product) {
        self.product = product
        
        self.title = product.title
        self.priceFormatted = (product.price).toFormattedPrice()
        self.thumbnail = product.thumbnail
        self.hasFreeShipping = product.shipping?.freeShipping ?? false
    }
    
    var freeShippingText: String? {
        return product.freeShippingText()
    }
}
