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
                        PictureView(urlString: picture.url)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                if pictures.count > 1 {
                    HStack(spacing: 8) {
                        let visibleDots = min(pictures.count, 4)
                        let startIndex = min(max(0, currentIndex - visibleDots/2), pictures.count - visibleDots)
                        
                        ForEach(startIndex..<startIndex+visibleDots, id: \.self) { index in
                            Circle()
                                .fill(currentIndex == index ? Color.primaryColor : Color.gray.opacity(0.5))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.top, 8)
                    .animation(.easeInOut, value: currentIndex)
                }
            }
        }
    }
}

struct PictureView: View {
    let urlString: String?
    
    private var secureUrl: URL? {
        guard let originalString = urlString else { return nil }
        let secureString = originalString.replacingOccurrences(of: "http://", with: "https://")
        return URL(string: secureString)
    }
    
    var body: some View {
        AsyncImage(
            url: secureUrl,
            content: { image in
                image
                    .resizable()
                    .scaledToFit()
            },
            placeholder: {
                Image(systemName: IconNames.emptyImage)
                    .modifier(PlaceholderImageModifier())
            }
        )
    }
}
