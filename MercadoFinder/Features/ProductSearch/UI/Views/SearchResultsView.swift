//
//  SearchResultsView.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//


import SwiftUI

struct SearchResultsView: View {
    let state: SearchState
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                contentView
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch state {
        case .empty:
            EmptyStateView(iconName: IconNames.search,
                           title: AppText.Search.welcome,
                           message: AppText.Search.slogan)
        case .loading:
            LoadingStateView()
        case .success(let products):
            ProductList(products: products)
        case .failure(let error, let retryAction):
            ErrorStateView(error: error, onRetry: retryAction)
        }
    }
}

// MARK: - Component Views

private struct ProductList: View {
    let products: [Product]
    
    var body: some View {
        ForEach(products) { product in
            NavigationLink(destination:
                            ProductDetailView(viewModel: ProductDetailViewModel(productId: product.id ?? ""))) {
                ProductRowItem(product: product)
            }
                            .buttonStyle(PlainButtonStyle())
        }
    }
}

private struct LoadingStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            ForEach(0..<5, id: \.self) { _ in
                SkeletonProductRow()
            }
        }
    }
}

// MARK: - Previews
#Preview("Products List") {
    NavigationStack {
        SearchResultsView(
            state: .success([
                Product(
                    id: "MLA1",
                    title: "iPad Pro 12.9-inch",
                    price: 320000,
                    thumbnail: "https://http2.mlstatic.com/D_816036-MLA71235224424_082023-C.jpg",
                    pictures: nil,
                    condition: "new",
                    shipping: Shipping(freeShipping: true),
                    soldQuantity: 100,
                    availableQuantity: 50,
                    description: nil
                ),
                Product(
                    id: "MLA2",
                    title: "Apple iPad Air 10.9-inch",
                    price: 480000,
                    thumbnail: "https://http2.mlstatic.com/D_Q_NP_2X_685126-MLU69497701479_052023-R.webp",
                    pictures: nil,
                    condition: nil,
                    shipping: Shipping(freeShipping: false),
                    soldQuantity: nil,
                    availableQuantity: nil,
                    description: nil
                )
            ])
        )
    }
}

#Preview("Loading State") {
    NavigationStack {
        SearchResultsView(state: .loading)
    }
}

#Preview("Empty State") {
    NavigationStack {
        SearchResultsView(state: .empty)
    }
}

#Preview("Error State") {
    NavigationStack {
        SearchResultsView(
            state: .failure(
                NetworkError.serverError(statusCode: 404),
                retryAction: {}
            )
        )
    }
}
