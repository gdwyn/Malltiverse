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
            VStack(spacing: 24) {
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
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack{
                                    ForEach(1..<4, id: \.self) { card in
                                        HeadPhoneCard()
                                           // .padding(.horizontal, 24)
                                            .containerRelativeFrame(.horizontal, count: 1, spacing: 24)
                                            .scrollTransition { content, phase in
                                                content
                                                    .opacity(phase.isIdentity ? 1 : 0)
                                                    .scaleEffect(phase.isIdentity ? 1 : 0)
                                            }
                                    }
                                }
                                .scrollTargetLayout()
                            }
                            .contentMargins(14, for: .scrollContent)
                            .scrollTargetBehavior(.viewAligned)
                                
                                VStack(alignment: .leading, spacing: 16) {
                                    Text("Tech gadgets")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, 24)
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            Spacer()
                                                .frame(width: 24)
                                            LazyHStack(spacing: 14) {
                                                ForEach(vm.filterProducts(forCategory: "tech gagdet")) { item in
                                                    ProductCard(item: item) {
                                                        vm.addItem(item)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .padding(.bottom, 58)
                                }// tech
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Men’s Fashion")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 24)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        Spacer()
                                            .frame(width: 24)
                                        LazyHStack(spacing: 14) {
                                            ForEach(vm.filterProducts(forCategory: "men's fashion")) { item in
                                                ProductCard(item: item) {
                                                    vm.addItem(item)
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.bottom, 58)
                            }// men
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Women's Fashion")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 24)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        Spacer()
                                            .frame(width: 24)
                                        LazyHStack(spacing: 14) {
                                            ForEach(vm.filterProducts(forCategory: "men's fashion")) { item in
                                                ProductCard(item: item) {
                                                    vm.addItem(item)
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.bottom, 58)
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
            .toolbar(.hidden, for: .tabBar)
        
        }
        
    }

#Preview {
    HomeView()
}

