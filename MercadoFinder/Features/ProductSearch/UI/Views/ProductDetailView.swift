//
//  ProductDetailView.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 02/03/2025.
//

import SwiftUI

struct ProductDetailView: View {
    @StateObject private var viewModel: ProductDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: ProductDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: IconNames.backArrow)
                            .foregroundColor(.black)
                            .imageScale(.large)
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.yellow.opacity(0.8), for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
            .onDisappear {
                viewModel.cancelOngoingTasks()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProductDetailSkeletonView()
        case .loaded(let product):
            ProductDetailContentView(product: product, productURL: viewModel.getProductURL())
        case .error(let error, let retryAction):
            ErrorStateView(error: error, onRetry: retryAction)
        }
    }
}

// MARK: - Content Components
private struct ProductDetailContentView: View {
    let product: Product
    let productURL: URL?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                TitleSection(title: product.title)
                
                VStack(alignment: .leading, spacing: 16) {
                    ProductInfoSection(product: product)
                    ImageSection(pictures: product.pictures)
                    PriceAndShippingSection(product: product)
                }
                .padding(.horizontal)
                
                Spacer(minLength: 10)
                
                if let url = productURL {
                    BuyButton(url: url)
                }
            }
            .padding(.vertical)
        }
        .scrollIndicators(.hidden)
    }
}

// MARK: - Section Components
private struct TitleSection: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.regular)
            .lineLimit(5)
            .padding(.leading, 8)
    }
}

private struct ProductInfoSection: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ConditionLabel(condition: product.conditionString())
            WarrantyInfo(warranty: product.warranty)
        }
    }
}

private struct ConditionLabel: View {
    let condition: String?
    
    var body: some View {
        if let condition = condition {
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
}

private struct WarrantyInfo: View {
    let warranty: String?
    
    var body: some View {
        if let warranty = warranty {
            HStack(spacing: 4) {
                Image(systemName: IconNames.shield)
                    .foregroundColor(.green)
                Text(warranty)
                    .font(.subheadline)
            }
        }
    }
}

private struct ImageSection: View {
    let pictures: [Picture]?
    
    var body: some View {
        ImageCarousel(pictures: pictures ?? [])
            .frame(height: 360)
    }
}

private struct PriceAndShippingSection: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            PriceView(price: product.price)
            ShippingView(product: product)
        }
    }
}

private struct PriceView: View {
    let price: Double
    
    var body: some View {
        Text(price.toFormattedPrice())
            .font(.title)
            .fontWeight(.semibold)
    }
}

private struct ShippingView: View {
    let product: Product
    
    var body: some View {
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
}

private struct BuyButton: View {
    @Environment(\.openURL) private var openURL
    let url: URL
    
    var body: some View {
        Button {
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
