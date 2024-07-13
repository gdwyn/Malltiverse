//
//  ProductCard.swift
//  Tim Store
//
//  Created by Godwin IE on 06/07/2024.
//

import SwiftUI

struct ProductCard: View {
    var item: ItemsModel
    var action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack {
                
                if let imageUrl = item.photos.first?.url,
                   let url = URL(string: "https://api.timbu.cloud/images/\(imageUrl)") {
                    
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 130)
                            .padding(.vertical, 20)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 130)
                            .frame(height: 90)
                            .padding(.vertical, 20)
                    }
                }
                
            }
            .frame(width: 160, height: 160)
            .padding(16)
            .background(.gray.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            VStack(alignment: .leading, spacing: 10) {
                Text(item.name)
                    .lineLimit(1)
                    .fontWeight(.medium)
                    .foregroundStyle(.black)
                    .frame(width: 185, alignment: .leading)
                
                Text(item.description ?? "")
                    .lineLimit(1)
                    .foregroundStyle(.gray)
                    .frame(width: 185)
                
                ProductRating()
                
            }
            
            if let firstPriceValue = item.currentPrice.first?.NGN.first {
                // handle different PriceValue cases
                switch firstPriceValue {
                case .double(let value):
                    Text("N \(value, specifier: "%.2f")")
                        .foregroundStyle(.accent)
                case .array(let values):
                    // format array of doubles into a string
                    let formattedValues = values.map { String($0) }.joined(separator: ", ")
                    Text("N [\(formattedValues)]")
                case .empty:
                    Text("N/A")
                }
            } else {
                Text("N/A")
            } //price
            
            PrimaryButton(title: "Add to cart", isFilled: false) {
                action()
            }
            
            
        }
    }
    
}
