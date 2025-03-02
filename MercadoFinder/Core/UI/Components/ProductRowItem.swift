//
//  ProductListItem.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import SwiftUI

struct ProductRowItem: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @ObservedObject private var viewModel: ProductRowItemViewModel
    
    init(product: Product) {
        self._viewModel = ObservedObject(wrappedValue: ProductRowItemViewModel(product: product))
    }
    
    var body: some View {
        HStack(spacing: 12) {
            ProductImageView(urlString: viewModel.thumbnail)
            
            if verticalSizeClass == .regular {
                ProductDetailsView(title: viewModel.title, price: viewModel.priceFormatted, hasFreeShipping: viewModel.hasFreeShipping, isPortrait: true)
            } else {
                ProductDetailsView(title: viewModel.title, price: viewModel.priceFormatted, hasFreeShipping: viewModel.hasFreeShipping, isPortrait: false)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.primary.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

struct ProductImageView: View {
    let urlString: String?

    var body: some View {
        if let url = urlString, !url.isEmpty {
            URLImageView(urlString: url)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.primary)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}


struct ProductDetailsView: View {
    let title: String
    let price: String
    let hasFreeShipping: Bool
    let isPortrait: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .fontWeight(.medium)
                .lineLimit(isPortrait ? 2 : 1)
            
            ProductPriceView(price: price, hasFreeShipping: hasFreeShipping)
        }
    }
}

struct ProductPriceView: View {
    let price: String
    let hasFreeShipping: Bool
    
    var body: some View {
        HStack {
            Text(price)
                .font(.title3)
                .fontWeight(.regular)
            
            Spacer()
            
            if hasFreeShipping {
                ProductLabel(
                    backgroundColor: .highlightBackground,
                    cornerRadius: 4,
                    fontSize: 12,
                    height: 22,
                    text: AppText.Product.freeShipping,
                    textColor: .highlightColor
                )
            }
        }
    }
}

#Preview {
    ProductRowItem(product: Product(
        id: "MLA1234",
        title: "MacBook Pro 16-inch 2023",
        price: 2499.99,
        thumbnail: "https://static.thenounproject.com/png/1583621-200.png",
        pictures: nil,
        shipping: Shipping(freeShipping: true)
    ))
    .padding()
    .background(Color.gray.opacity(0.1))
}
