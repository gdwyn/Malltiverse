//
//  CustomTabView.swift
//  Malltiverse
//
//  Created by Godwin IE on 13/07/2024.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNamespace
    
    let tabBarItems: [(image: String, title: String)] = [
        ("khome", "home"),
        ("kcart", "cart"),
        ("kcart1", "checkout"),

    ]
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 67)
                .foregroundColor(.dark)
            
            HStack (spacing: 74) {
                ForEach (0..<3) { item in
                    Button {
                        withAnimation {
                            tabSelection = item + 1
                        }
                    } label: {
                        ZStack{
                            Circle()
                                .frame(
                                    width: item + 1 == tabSelection ?  34 : 0)
                            
                        //    Image("khome")
                            Image(tabBarItems[item].image)
                                .renderingMode(.template)
                                .foregroundStyle(item + 1 == tabSelection ? .dark : .white)
                        }
                        .frame(width: 34)
                    }
                }
            }
            .frame(height: 67)
            
        }
        .padding(.horizontal,24)
    }
}

#Preview {
    CustomTabView(tabSelection: .constant(1))
}
