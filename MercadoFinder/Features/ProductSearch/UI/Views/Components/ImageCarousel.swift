//
//  ImageCarousel.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 02/03/2025.
//

import SwiftUI

// MARK: - Image Carousel Component
struct ImageCarousel: View {
    let pictures: [Picture]
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            if pictures.isEmpty {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 360)
                    .overlay(
                        Image(systemName: IconNames.emptyImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                    )
            } else {
                TabView(selection: $currentIndex) {
                    ForEach(Array(pictures.enumerated()), id: \.element.id) { index, picture in
                        AsyncImage(
                            url: URL(string: picture.url ?? ""),
                            content: { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                
                if pictures.count > 1 {
                    HStack(spacing: 8) {
                        ForEach(0..<pictures.count, id: \.self) { index in
                            Circle()
                                .fill(currentIndex == index ? Color.primary : Color.gray.opacity(0.5))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.top, 8)
                }
            }
        }
    }
}
