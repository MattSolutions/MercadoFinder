//
//  ProductsUIComponents.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 02/03/2025.
//

import SwiftUI

// MARK: - Product Information Components
struct ProductTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.regular)
            .lineLimit(5)
    }
}

struct ProductStockView: View {
    let product: Product
    
    var body: some View {
        Text(product.stockString())
            .font(.headline)
            .fontWeight(.light)
    }
}

struct ProductAttributesView: View {
    let product: Product
    var alignment: HorizontalAlignment
    var spacing: CGFloat
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            if product.hasWarranty(), let warranty = product.warranty {
                ProductLabel(
                    backgroundColor: Color(.systemTeal),
                    cornerRadius: 8,
                    fontSize: 12,
                    height: 30,
                    text: warranty,
                    textColor: .white
                )
            }
        }
    }
}
