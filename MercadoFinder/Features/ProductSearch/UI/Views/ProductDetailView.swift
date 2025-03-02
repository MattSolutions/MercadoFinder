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
                ProductTitleView(title: product.title)
                    .padding(.leading, 8)
                
                VStack(alignment: .leading, spacing: 16) {
                    ProductAttributesView(
                        conditionString: product.conditionString(),
                        warranty: product.warranty,
                        alignment: .leading,
                        spacing: 8
                    )
                    
                    ProductImageSection(
                        pictures: product.pictures,
                        thumbnail: product.thumbnail
                    )
                    
                    ProductPriceTag(price: product.price)
                    
                    if let freeShippingText = product.freeShippingText() {
                        ProductFreeShippingTag(text: freeShippingText)
                    }
                }
                .padding(.horizontal)
                
                Spacer(minLength: 10)
                
                if let productId = product.id {
                    BuyButton(productId: productId, permalink: product.permalink)
                }
            }
            .padding(.vertical)
        }
    }
}

// MARK: - Product Information Subcomponents
struct ProductTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.regular)
            .lineLimit(5)
    }
}

struct ProductAttributesView: View {
    let conditionString: String?
    let warranty: String?
    var alignment: HorizontalAlignment
    var spacing: CGFloat
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            
            if let condition = conditionString {
                ProductConditionTag(condition: condition)
            }
            
            if let warranty = warranty {
                HStack(spacing: 4) {
                    Image(IconNames.shield)
                        .foregroundColor(.green)
                    Text(warranty)
                        .font(.subheadline)
                }
            }
        }
    }
}

struct ProductConditionTag: View {
    let condition: String
    
    var body: some View {
        ProductLabel(
            backgroundColor: .gray.opacity(0.1),
            cornerRadius: 4,
            fontSize: 12,
            height: 24,
            text: condition,
            textColor: .gray
        )
    }
}

struct ProductImageSection: View {
    let pictures: [Picture]?
    let thumbnail: String?
    
    var body: some View {
        if let pictures = pictures, !pictures.isEmpty {
            ImageCarousel(pictures: pictures)
                .frame(height: 360)
        } else if let thumbnail = thumbnail {
            URLImageView(urlString: thumbnail)
                .aspectRatio(contentMode: .fit)
                .frame(height: 360)
        }
    }
}

struct ProductPriceTag: View {
    let price: Double
    
    var body: some View {
        Text(price.toFormattedPrice())
            .font(.title)
            .fontWeight(.semibold)
    }
}

struct ProductFreeShippingTag: View {
    let text: String
    
    var body: some View {
        ProductLabel(
            backgroundColor: .highlightBackground,
            cornerRadius: 8,
            fontSize: 14,
            height: 30,
            text: text,
            textColor: .highlightColor
        )
    }
}

struct BuyButton: View {
    @Environment(\.openURL) private var openURL
    let productId: String
    let permalink: String?
    
    var body: some View {
        Button {
            guard
                let permalink = permalink,
                let url = URL(string: permalink)
            else { return }
            
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
