//
//  AppTabView.swift
//  Malltiverse
//
//  Created by Godwin IE on 13/07/2024.
//

import Combine
import SwiftUI

struct AppTabView: View {
    @StateObject var homeViewModel = HomeViewModel()

    @State private var tabSelection = 1
    
    @State private var isKeyboardVisible = false
    
    var body: some View {
        TabView(selection: $tabSelection) {
            HomeView(tabSelection: $tabSelection)
                .environmentObject(homeViewModel)
                .tag(1)
            
            CartView(tabSelection: $tabSelection)
                .environmentObject(homeViewModel)
                .tag(2)
            
            PaymentView(tabSelection: $tabSelection)
                .environmentObject(homeViewModel)
                .tag(3)
        }
        .overlay(alignment: .bottom) {
                    if !isKeyboardVisible {
                        if homeViewModel.tabOpacity {
                            CustomTabView(tabSelection: $tabSelection)
                        } else {
                            Color.clear
                                .frame(height: 0)
                        }
                    }
                }
                .keyboardAware(isKeyboardVisible: $isKeyboardVisible)
    }
}

//#Preview {
//    AppTabView()
//}
