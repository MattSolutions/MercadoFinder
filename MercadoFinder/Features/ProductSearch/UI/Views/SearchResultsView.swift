//
//  SearchResultsView.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//


import SwiftUI

enum ProductListState {
    case loading
    case loaded([Product])
    case error(Error, (() -> Void)?)
    case empty
}

struct SearchResultsView: View {
    let state: ProductListState
    
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
        case .loading:
            LoadingStateView()
        case .loaded(let products):
            ProductList(products: products)
        case .error(let error, let onRetry):
            ErrorStateView(error: error, onRetry: onRetry)
        case .empty:
            EmptyStateView(iconName: IconNames.search,
                           title: AppText.Search.welcome,
                           message: AppText.Search.slogan)
        }
    }
}

// MARK: - Component Views

private struct ProductList: View {
    let products: [Product]
    
    var body: some View {
        ForEach(products) { product in
            ProductRowItem(product: product)
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
            state: .loaded([
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
            state: .error(
                NetworkError.serverError(statusCode: 404),
                {}
            )
        )
    }
}
