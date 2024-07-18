//
//  ViewModel.swift
//  Tim Store
//
//  Created by Godwin IE on 06/07/2024.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published private var path = NavigationPath()

    @Published var products: [ItemsModel] = []
    @Published var cartItems: [ItemsModel] = []
    @Published var history: [ItemsModel] = []
    @Published var favorites: [ItemsModel] = []

    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var tabOpacity = true
    
    
    func removeItem(_ item: ItemsModel) {
            if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
                cartItems.remove(at: index)
            }
        }
    
    func addItem(_ item: ItemsModel) {
        //check if item is already on our list
        if let index = cartItems.firstIndex(where: { $0.id == item.id
        }) {
            //increase qty if we have item
            cartItems[index].availableQuantity += 1
        } else {
            //else add item
            var newItem = item
            newItem.availableQuantity = 1
            cartItems.append(newItem)
        }
    }
    
    func filterProducts(forCategory categoryName: String) -> [ItemsModel] {
            products.filter { item in
                item.categories.contains { $0.name == categoryName }
            }
        }
    
    func loadProducts() async {
                
        DispatchQueue.main.async {
                   self.isLoading = true
               }
        
        do {
            
            let productsModel = try await getProducts()
                        
            DispatchQueue.main.async {
                self.products = productsModel.items
                self.isLoading = false
            } //update products array
                        
            
        } catch AppErrors.invalidData {
            DispatchQueue.main.async {
                self.errorMessage = "The data provided is invalid. Please try again."
                self.isLoading = false
            }
            
        } catch AppErrors.invalidResponse {
            
            DispatchQueue.main.async {
                self.errorMessage = "Invalid response from the server. Please try again."
                self.isLoading = false
            }
            
        } catch AppErrors.invalidURL {
            DispatchQueue.main.async {
                self.errorMessage = "The url provided is invalid. Please try again."
                self.isLoading = false
            }
        } catch let error as URLError {
            DispatchQueue.main.async {
                if error.code == .notConnectedToInternet {
                    self.errorMessage = "No internet connection. Please check your network settings."
                }
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Something is wrong"
                self.isLoading = false
            }
        }
    } // loadproducts func

}
