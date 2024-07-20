//
//  ProductCard.swift
//  Tim Store
//
//  Created by Godwin IE on 06/07/2024.
//

import SwiftUI

struct ProductCard: View {
    var item: ItemsModel
    @EnvironmentObject var vm: HomeViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            
            NavigationLink {
                DetailView(product: item)
            } label: {
                ZStack(alignment: .topTrailing) {
                        
                        if let imageUrl = item.photos.first?.url,
                           let url = URL(string: "https://api.timbu.cloud/images/\(imageUrl)") {
                            
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 84, height: 84)
                                    .padding(40)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 84, height: 84)
                                    .padding(40)
                            }
                        }
                                        
                        Button {
                            vm.bookmarks.contains(where: { $0.id == item.id })
                            ? vm.removeBookmark(item)
                            : vm.bookmarks.append(item)

                        } label: {
                            Image(systemName: vm.bookmarks.contains(where: { $0.id == item.id })
                                ? "bookmark.fill"
                                : "bookmark")
                                .padding(10)
                                .background(.white)
                                .clipShape(.circle)
                        }
                        .padding(10)
                    
                }
                .background(.gray.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(item.name)
                    .lineLimit(1)
                    .fontWeight(.medium)
                    .foregroundStyle(.black)
                    .frame(width: 150, alignment: .leading)
                
                Text(item.description ?? "")
                    .lineLimit(1)
                    .foregroundStyle(.gray)
                    .frame(width: 150)
                
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
            
            SecondaryButton(title: "Add to cart") {
                vm.addItem(item)
            }
            
            
        }
    }
    
}
