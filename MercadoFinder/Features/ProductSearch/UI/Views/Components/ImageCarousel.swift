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
                EmptyImagePlaceholder()
            } else {
                CarouselContent(pictures: pictures, currentIndex: $currentIndex)
            }
        }
    }
}

private struct EmptyImagePlaceholder: View {
    var body: some View {
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
    }
}

private struct CarouselContent: View {
    let pictures: [Picture]
    @Binding var currentIndex: Int

    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(pictures.indices, id: \.self) { index in
                    PictureView(urlString: pictures[index].url)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            if pictures.count > 1 {
                PageIndicator(currentIndex: currentIndex, totalCount: pictures.count)
            }
        }
    }
}

private struct PageIndicator: View {
    let currentIndex: Int
    let totalCount: Int

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(0..<totalCount, id: \.self) { index in
                        Circle()
                            .fill(currentIndex == index ? Color.primaryColor : Color.gray.opacity(0.5))
                            .frame(width: 8, height: 8)
                            .id(index)
                    }
                }
                .padding(.horizontal, 8)
            }
            .frame(width: 80, height: 20)
            .onChange(of: currentIndex) {
                withAnimation {
                    proxy.scrollTo(currentIndex, anchor: .center)
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
