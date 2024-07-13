//
//  DetailView.swift
//  Tim Store
//
//  Created by Godwin IE on 06/07/2024.
//

import SwiftUI

struct DetailView: View {
    var product: ItemsModel
    
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var toastScale = 0.0
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading, spacing: 18) {
                    
                    if let imageUrl = product.photos.first?.url,
                       let url = URL(string: "https://api.timbu.cloud/images/\(imageUrl)") {
                        
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .frame(height: 240)
                                .background(.gray.opacity(0.1))
                                .cornerRadius(24)
                            
                        } placeholder: {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .frame(height: 260)
                                .background(.gray.opacity(0.1))
                                .cornerRadius(24)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(product.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        if let firstPriceValue = product.currentPrice.first?.NGN.first {
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
                    } // name and price
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("DESCRIPTION")
                                .foregroundStyle(.gray)
                                .font(.callout)
                            
                            if let description = product.description {
                                Text(description)
                                    .lineSpacing(6)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    HStack {
                        PrimaryButton(title: "Add to cart", isFilled: true) {
                            showToast(message: "\(product.name) added to cart!")
                            withAnimation(.easeInOut(duration: 0.4)) {
                                toastScale = 1
                            
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("AVAILABILITY")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                            
                            HStack {
                                Circle()
                                    .frame(width: 8)
                                
                                Text("Item is \(product.isAvailable ? "available" : "Unavailable")")
                            }
                            .foregroundStyle(product.isAvailable ? .green : .gray)
                            
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    
                }
                .padding(.top)
                .padding(.horizontal)
                
                if showToast {
                    VStack {
                        Toast(message: toastMessage)
                            .padding(.top, 32)
                            .scaleEffect(toastScale)
                        Spacer()
                    }
                } //toast
                
            }
        }
    }
    
    private func showToast(message: String) {
        toastMessage = message
        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showToast = false
            toastScale = 0
        }
    }
}
