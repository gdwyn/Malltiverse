//
//  HistoryView.swift
//  Malltiverse
//
//  Created by Godwin IE on 18/07/2024.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if !vm.history.isEmpty {
                    HStack {
                        Text("History")
                            .bold()
                        
                        Spacer()
                        
                        Button("Clear history") {
                            vm.history.removeAll()
                        }
                        .font(.callout)
                        .foregroundStyle(.gray)
                    }
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            ForEach($vm.history, id: \.id) { $history in
                                NavigationLink {
                                    DetailView(product: history)
                                } label: {
                                    
                                    HStack(spacing: 18) {
                                        
                                        if let imageUrl = history.photos.first?.url,
                                           let url = URL(string: "https://api.timbu.cloud/images/\(imageUrl)") {
                                            
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 80, height: 80)
                                                    .padding()
                                                    .background(.gray.opacity(0.05))
                                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 18, height: 18)))
                                                
                                            } placeholder: {
                                                ProgressView()
                                                    .frame(width: 80, height: 80)
                                                //.background(.gray.opacity(0.1))
                                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 18, height: 18)))
                                            }
                                            
                                        }
                                        
                                        
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(history.name)
                                            
                                            HStack {
                                                Text(String(format: "%.0f pcs", history.availableQuantity))
                                                    .foregroundStyle(.gray)
                                                
                                                Spacer()
                                                
                                                if let firstPriceValue = history.currentPrice.first?.NGN.first {
                                                    switch firstPriceValue {
                                                    case .double(let value):
                                                        Text("N \(value * history.availableQuantity, specifier: "%.2f")")
                                                            .foregroundStyle(.gray)
                                                            .font(.callout)
                                                    case .array(let values):
                                                        let formattedValues = values.map { String($0) }.joined(separator: ", ")
                                                        Text("N [\(formattedValues)]")
                                                    case .empty:
                                                        Text("N/A")
                                                    }
                                                } else {
                                                    Text("N/A")
                                                } //price
                                            }
                                        }
                                        
                                        
                                        
                                    }
                                }
                            }
                        }
                        
                    }
                } else {
                    ContentUnavailableView(
                        "No orders yet",
                        systemImage: "cart.fill",
                        description: Text(""))
                }
            }
            .padding()
            .toolbar(.hidden, for: .tabBar)
            
        }
    }
}

#Preview {
    HistoryView()
}
