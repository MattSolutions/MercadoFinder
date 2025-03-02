//
//  SearchBar.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var height: CGFloat = 45
    var iconSize: CGFloat = 22
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                
                HStack(spacing: 15) {
                    Image(systemName: IconNames.search)
                        .foregroundColor(.gray)
                        .font(.system(size: iconSize, weight: .medium))
                        .padding(.leading, 15)
                    
                    TextField(AppText.Search.placeholder, text: $text)
                        .font(.system(size: iconSize * 0.8, weight: .regular))
                        .submitLabel(.search)
                        .onSubmit(onSearch)
                }
            }
            .frame(height: height)
            
            if !text.isEmpty {
                Button {
                    withAnimation(.spring()) {
                        text = ""
                        onSearch()
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: height - 10, height: height - 10)
                        
                        Image(systemName: IconNames.clear)
                            .foregroundColor(.gray)
                            .font(.system(size: iconSize - 4, weight: .medium))
                    }
                }
                .transition(.scale)
                .animation(.spring(), value: text)
            }
        }
    }
}

#Preview {
    SearchBar(text: .constant("Macbook Pro M3 Max"), onSearch: {})
        .padding()
        .background(Color.yellow)
        .frame(height: 100)
}
