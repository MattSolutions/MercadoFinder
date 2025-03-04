//
//  ProductDetailSkeletonView.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 02/03/2025.
//

import SwiftUI

// MARK: - Loading State
struct ProductDetailSkeletonView: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 16)
                    .cornerRadius(4)
                    .frame(width: 80)
                Spacer()
            }

            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 360)
                .cornerRadius(8)

            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 24)
                        .cornerRadius(4)

                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 30)
                        .cornerRadius(4)
                        .frame(width: 150)

                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 18)
                        .cornerRadius(4)
                        .frame(width: 120)
                }
                Spacer()
            }

            HStack {
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 120, height: 30)
                Spacer()
            }

            Capsule()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 180, height: 40)
                .padding(.top, 20)
        }
    }
}
