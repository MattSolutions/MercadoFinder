//
//  ProductDetailView.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 02/03/2025.
//

import SwiftUI

struct ProductDetailView: View {
    @StateObject private var viewModel: ProductDetailViewModel
    
    init(productId: String) {
        _viewModel = StateObject(wrappedValue: ProductDetailViewModel(productId: productId))
    }
    
    var body: some View {
        content
            .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProductDetailSkeletonView()
        case .loaded(let product):
            ProductDetailContentView(product: product)
        case .error(let error, let onRetry):
            ErrorStateView(error: error, onRetry: onRetry)
        }
    }
}

// MARK: - Content View
struct ProductDetailContentView: View {
    let product: Product
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.title2)
                    .fontWeight(.regular)
                    .lineLimit(5)
                    .padding(.leading, 8)
                
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        if let condition = product.conditionString() {
                            ProductLabel(
                                backgroundColor: .gray.opacity(0.1),
                                cornerRadius: 4,
                                fontSize: 12,
                                height: 24,
                                text: condition,
                                textColor: .gray
                            )
                        }
                        
                        if let warranty = product.warranty {
                            HStack(spacing: 4) {
                                Image(systemName: IconNames.shield)
                                    .foregroundColor(.green)
                                Text(warranty)
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                    // Image Section
                    if let pictures = product.pictures, !pictures.isEmpty {
                        ImageCarousel(pictures: pictures)
                            .frame(height: 360)
                    } else if let thumbnail = product.thumbnail {
                        URLImageView(urlString: thumbnail)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 360)
                    }
                    
                    // Price
                    Text(product.price.toFormattedPrice())
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    // Free Shipping
                    if let freeShippingText = product.freeShippingText() {
                        ProductLabel(
                            backgroundColor: .highlightBackground,
                            cornerRadius: 8,
                            fontSize: 14,
                            height: 30,
                            text: freeShippingText,
                            textColor: .highlightColor
                        )
                    }
                }
                .padding(.horizontal)
                
                Spacer(minLength: 10)
                
                if let permalink = product.permalink {
                    BuyButton(permalink: permalink)
                }
            }
            .padding(.vertical)
        }
    }
}

// MARK: - Buy Button
struct BuyButton: View {
    @Environment(\.openURL) private var openURL
    let permalink: String
    
    var body: some View {
        Button {
            guard let url = URL(string: permalink) else { return }
            openURL(url)
        } label: {
            HStack {
                Spacer()
                Text(AppText.Product.buy)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}

#Preview {
    NavigationStack {
        ProductDetailView(productId: "MLA935834730")
    }
}
