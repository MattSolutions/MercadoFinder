//
//  URLImageView.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 01/03/2025.
//


import SwiftUI

struct URLImageView: View {
    var urlString: String?

    private var secureUrl: URL? {
        guard let originalString = urlString else { return nil }
        return URL(string: originalString.replacingOccurrences(of: "http://", with: "https://"))
    }

    var body: some View {
        AsyncImage(url: secureUrl) { phase in
            switch phase {
            case .success(let image):
                image.resizable().scaledToFit()

            case .failure:
                Image(systemName: IconNames.failImage)
                    .modifier(PlaceholderImageModifier())

            case .empty:
                Image(systemName: IconNames.emptyImage)
                    .modifier(PlaceholderImageModifier())

            @unknown default:
                Image(systemName: IconNames.failImage)
                    .modifier(PlaceholderImageModifier())
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct PlaceholderImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .foregroundColor(.primaryColor)
            .padding(8)
    }
}

struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(urlString: "https://http2.mlstatic.com/D_NQ_NP_2X_624227-MLU71266371683_082023-T.webp")
            .previewLayout(.sizeThatFits)
    }
}
