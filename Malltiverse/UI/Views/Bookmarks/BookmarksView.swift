//
//  FavoritesView.swift
//  Malltiverse
//
//  Created by Godwin IE on 18/07/2024.
//

import SwiftUI

struct BookmarksView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if !vm.bookmarks.isEmpty {
                    HStack {
                        Text("Favorites")
                            .bold()
                        
                        Spacer()
                        
                        Button("Clear favorites") {
                            vm.bookmarks.removeAll()
                        }
                        .font(.callout)
                        .foregroundStyle(.gray)
                    }
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                           
                                ForEach($vm.bookmarks, id: \.id) { $bookmark in
                                    NavigationLink {
                                        DetailView(product: bookmark)
                                    } label: {
                                        
                                    HStack(spacing: 18) {
                                        
                                        if let imageUrl = bookmark.photos.first?.url,
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
                                            HStack {
                                                Text(bookmark.name)
                                                    .foregroundStyle(.dark)
                                                    .multilineTextAlignment(.leading)
                                                
                                                Spacer()
                                                
                                                Button {
                                                    withAnimation {
                                                        vm.removeBookmark(bookmark) 
                                                    }
                                                } label: {
                                                    Image(systemName: "bookmark.fill")
                                                        .foregroundStyle(.gray)
                                                        .padding(10)
                                                        .background(.gray.opacity(0.1))
                                                        .clipShape(.circle)
                                                }
                                            }
                                            
                                            HStack {
                                                Text(String(format: "%.0f pcs", bookmark.availableQuantity))
                                                    .foregroundStyle(.gray)
                                                
                                                Spacer()
                                                
                                                if let firstPriceValue = bookmark.currentPrice.first?.NGN.first {
                                                    switch firstPriceValue {
                                                    case .double(let value):
                                                        Text("N \(value * bookmark.availableQuantity, specifier: "%.2f")")
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
                    ContentUnavailableView("No orders yet", systemImage: "cart.fill", description: Text("Add items to your cart"))
                }
            }
            //.navigationTitle("History")
            .padding()
            .toolbar(.hidden, for: .tabBar)
            .onAppear {
                withAnimation {
                    vm.tabOpacity = false
                }
            }
            .onDisappear {
                withAnimation {
                    vm.tabOpacity = true
                }
            }
            
        }
    }
}

#Preview {
    BookmarksView()
}
