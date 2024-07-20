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
            HomeView()
                .environmentObject(homeViewModel)
                .tag(1)
            
            CartView()
                .environmentObject(homeViewModel)
                .tag(2)
            
            PaymentView()
                .environmentObject(homeViewModel)
                .tag(3)
        }
        .overlay(alignment: .bottom) {
                    if !isKeyboardVisible {
                        CustomTabView(tabSelection: $tabSelection)
                            .opacity(homeViewModel.tabOpacity ? 1 : 0)
                            .scaleEffect(homeViewModel.tabOpacity ? 1 : 0)
                    }
                }
                .keyboardAware(isKeyboardVisible: $isKeyboardVisible)
    }
}

//#Preview {
//    AppTabView()
//}
