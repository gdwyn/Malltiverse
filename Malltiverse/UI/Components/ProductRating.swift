//
//  ProductRating.swift
//  Malltiverse
//
//  Created by Godwin IE on 12/07/2024.
//

import SwiftUI

struct ProductRating: View {
    let rating = 5
    let maximumRating = 5
    
//    init() {
//        self.rating = Int.random(in: 1...5)
//    }
    
    var body: some View {
        HStack(spacing: 1) {
            ForEach(1...maximumRating, id: \.self) { number in
                Star(filled: number <= rating)
            }
        }
    }
}

struct Star: View {
    let filled: Bool
    
    var body: some View {
        Image(systemName: filled ? "star.fill" : "star")
            .foregroundColor(.yellow)
            .font(.system(size: 16))
    }
}

#Preview {
    ProductRating()
}
