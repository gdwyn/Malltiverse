//
//  ProductCard.swift
//  Tim Store
//
//  Created by Godwin IE on 06/07/2024.
//

import SwiftUI

struct ProductCard: View {
    var item: ItemsModel
    var body: some View {
        VStack(alignment: .center) {
            
            Text(item.name)
                .foregroundStyle(.black)
            
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
            
            
            Spacer()
            
            if let firstPriceValue = item.currentPrice.first?.NGN.first {
                // handle different PriceValue cases
                switch firstPriceValue {
                case .double(let value):
                    Text("NGN \(value, specifier: "%.2f")")
                        .foregroundStyle(.gray)
                case .array(let values):
                    // format array of doubles into a string
                    let formattedValues = values.map { String($0) }.joined(separator: ", ")
                    Text("NGN [\(formattedValues)]")
                case .empty:
                    Text("N/A")
                        .foregroundColor(.red)
                }
            } else {
                Text("N/A")
                    .foregroundColor(.red)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(16)
        .background(.gray.opacity(0.05))
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 24, height: 24)))
    }
    
}
