//
//  HomeView.swift
//  Tim Store
//
//  Created by Godwin IE on 05/07/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: HomeViewModel

    @State private var errorMessage = ""
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                CustomAppBar(title: "Product List")
                    .padding(.horizontal, 24)
                
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
                            
                            HeadPhoneCard()
                                .padding(.horizontal, 24)
                                
                                VStack(alignment: .leading, spacing: 16) {
                                    Text("Tech gadgets")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, 24)
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        LazyHStack(spacing: 0) {
                                            ForEach(vm.filterProducts(forCategory: "tech gagdet")) { item in
                                                ProductCard(item: item) {
                                                    vm.addItem(item)
                                                }
                                                .padding(.leading, 24)
                                            }
                                            
                                            Spacer()
                                                .frame(width: 24)
                                        }
                                    }
                                    .padding(.bottom, 64)
                                }// tech
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Men’s Fashion")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 24)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 0) {
                                        ForEach(vm.filterProducts(forCategory: "men's fashion")) { item in
                                            ProductCard(item: item) {
                                                vm.addItem(item)
                                            }
                                            .padding(.leading, 24)
                                        }
                                        
                                        Spacer()
                                            .frame(width: 24)
                                    }
                                }
                                .padding(.bottom, 64)
                            }// men
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Men’s Fashion")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 24)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 0) {
                                        ForEach(vm.filterProducts(forCategory: "men's fashion")) { item in
                                            ProductCard(item: item) {
                                                vm.addItem(item)
                                            }
                                            .padding(.leading, 24)
                                        }
                                        
                                        Spacer()
                                            .frame(width: 24)
                                    }
                                }
                                .padding(.bottom, 64)
                            }// women
                            
                        }// scrollview
                    
                    }
                }
            }
            //            .padding(.horizontal, 24)
            //.padding(.top)
            .task{
                await vm.loadProducts()
            }
        }
        
    }

#Preview {
    HomeView()
}

