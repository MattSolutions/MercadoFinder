//
//  SearchView.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchHeader
                
                SearchResultsView(state: viewModel.state)
            }
            .navigationTitle("MercadoFinder")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
        }
    }
    
    // MARK: - Search Header
    private var searchHeader: some View {
        VStack(spacing: 15) {
            SearchBar(
                text: $viewModel.searchQuery,
                onSearch: performSearch
            )
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .background(Color.yellow.opacity(0.8))
    }
    
    // MARK: - Actions
    private func performSearch() {
        hideKeyboard()
        viewModel.search()
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    SearchView()
}
