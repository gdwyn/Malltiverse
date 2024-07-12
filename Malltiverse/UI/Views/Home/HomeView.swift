//
//  HomeView.swift
//  Tim Store
//
//  Created by Godwin IE on 05/07/2024.
//

import SwiftUI

struct HomeView: View {
    
    let columns = [GridItem(.adaptive(minimum: 200))]
    
    @ObservedObject var vm: HomeViewModel
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image("logo")
                    .resizable()
                    .frame(width: 34, height: 34)
                    .scaledToFit()
                
                if vm.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if let errorMessage = vm.errorMessage {
                    VStack(alignment: .center) {
                        Spacer()
                        Text("⚠️")
                            .font(.title)
                        Text(errorMessage)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        Button("Retry") {
                            Task {
                                await vm.loadProducts()
                            }
                        }
                        .padding()
                        Spacer()
                        Spacer()

                    }
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid (columns: columns) {
                            ForEach(vm.products) { item in
                                NavigationLink {
                                    DetailView(product: item)
                                } label: {
                                    ProductCard(item: item)
                                }
                            }
                        }
                    } // Vgrid
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .task{
                await vm.loadProducts()
        }
        }
        
    }
    
}

#Preview {
    HomeView(vm: HomeViewModel())
}
