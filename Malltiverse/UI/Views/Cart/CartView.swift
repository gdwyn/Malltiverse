//
//  CartView.swift
//  Malltiverse
//
//  Created by Godwin IE on 13/07/2024.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        NavigationStack{
            VStack {
                CustomAppBar(title: "Cart")
                    .padding(.horizontal, 24)

                if !vm.cartItems.isEmpty {
                    ScrollView {
                        VStack(spacing: 21) {
                            ForEach($vm.cartItems, id: \.id) { $checkoutItem in
                                HStack(alignment: .center, spacing: 18) {
                                    
                                    if let imageUrl = checkoutItem.photos.first?.url,
                                       let url = URL(string: "https://api.timbu.cloud/images/\(imageUrl)") {
                                        
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 80, height: 80)
                                               // .background(.gray.opacity(0.1))
                                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 18, height: 18)))
                                            
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: 80, height: 80)
                                                //.background(.gray.opacity(0.1))
                                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 18, height: 18)))
                                        }
                                        
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(checkoutItem.name)
                                                    .font(.callout)
                                                
                                                if let firstPriceValue = checkoutItem.currentPrice.first?.NGN.first {
                                                    // handle different PriceValue cases
                                                    switch firstPriceValue {
                                                    case .double(let value):
                                                        Text("N \(value * checkoutItem.availableQuantity, specifier: "%.2f")")
                                                            .foregroundStyle(.gray)
                                                            .font(.callout)
                                                    case .array(let values):
                                                        // format array of doubles into a string
                                                        let formattedValues = values.map { String($0) }.joined(separator: ", ")
                                                        Text("N [\(formattedValues)]")
                                                    case .empty:
                                                        Text("N/A")
                                                    }
                                                } else {
                                                   // Text("N/A")
                                                } //price
                                                
                                            }
                                            
                                            Spacer()
                                            
                                            Button(role: .destructive) {
                                                withAnimation(.easeInOut) {
                                                    vm.removeItem(checkoutItem)
                                                }
                                            } label: {
                                                Image(systemName: "trash")
                                                    .foregroundStyle(.gray)
                                            }
                                            .padding(10)
                                            
                                        }
                                                                                
                                        let formattedQuantity = String(format: "%.0f", checkoutItem.availableQuantity)

                                        Stepper("\(formattedQuantity) pcs", value: $checkoutItem.availableQuantity, in: 1...10)

                                    }
                                    
                                    
                                    
                                }
                                .padding(.vertical, 28)
                                .padding(.horizontal, 14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(.gray.opacity(0.2))
                                )
                                
                                
                            }
                            
                            ShoppingSummary()
                            
                            NavigationLink{
                                CheckoutView()
                            } label: {
                                Text("Checkout")
                                    .frame(maxWidth: .infinity)
                                    .font(.callout)
                                    .foregroundColor(.dark)
                                    .padding(18)
                                    .background(.accent)
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                        
                            }
                            .padding()
                            .padding(.bottom, 16)
                        }
                        .padding()
                    }
                } else {
                    ContentUnavailableView("Your cart is empty", systemImage: "cart.fill", description: Text("Add items to check out"))
                }
                
                   
            } //vstack
        }

    }
}

#Preview {
    CartView()
}
