//
//  CartViewModel.swift
//  Malltiverse
//
//  Created by Godwin IE on 13/07/2024.
//

import Foundation

class CartViewModel: ObservableObject {
        
    @Published var cartItems: [ItemsModel] = []

//    func removeItem(_ item: ItemsModel) {
//            if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
//                cartItems.remove(at: index)
//            }
//        }
//    
//    func addItem(_ item: ItemsModel) {
//        //check if item is already on our list
//        if let index = cartItems.firstIndex(where: { $0.id == item.id
//        }) {
//            //increase qty if we have item
//            cartItems[index].availableQuantity += 1
//        } else {
//            //else add item
//            var newItem = item
//            newItem.availableQuantity = 1
//            cartItems.append(newItem)
//        }
//    }
    
}
