//
//  CustomAppBar.swift
//  Malltiverse
//
//  Created by Godwin IE on 13/07/2024.
//

import SwiftUI

struct CustomAppBar: View {
    var title: String
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .frame(width: 99, height: 31)
                .scaledToFill()
            Spacer()
            Text(title)
                .fontWeight(.semibold)
            Spacer()
            
            NavigationLink{
                HistoryView()
            } label: {
                HStack{
                    Image(systemName: "clock")
                    Text("History")
                }
                .foregroundStyle(.gray)
                .frame(width: 99)

            }
        }
    }
}

#Preview {
    CustomAppBar(title: "Title")
}
