//
//  ViewModel.swift
//  Tim Store
//
//  Created by Godwin IE on 06/07/2024.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var showToast = false
    @Published var toastMessage = ""
    @Published var toastScale = 0.0
    
    @Published var products: [ItemsModel] = []

    // Cart list
    @Published var cartItems: [ItemsModel] = [] {
        didSet {
            let encoder = JSONEncoder()
            do {
                let encoded = try encoder.encode(cartItems)
                UserDefaults.standard.set(encoded, forKey: "CartItem")
            } catch {
                print("Failed to encode cartItems: \(error)")
            }
        }
    }

    // History
    @Published var history: [ItemsModel] = [] {
        didSet {
            let encoder = JSONEncoder()
            do {
                let encoded = try encoder.encode(history)
                UserDefaults.standard.set(encoded, forKey: "HistoryItem")
            } catch {
                print("Failed to encode history: \(error)")
            }
        }
    }

    // Bookmarks
    @Published var bookmarks: [ItemsModel] = [] {
        didSet {
            let encoder = JSONEncoder()
            do {
                let encoded = try encoder.encode(bookmarks)
                UserDefaults.standard.set(encoded, forKey: "BookmarkItem")
            } catch {
                print("Failed to encode bookmarks: \(error)")
            }
        }
    }

    init() {
        // Init cart
        if let savedItems = UserDefaults.standard.data(forKey: "CartItem"),
           let decodedItems = try? JSONDecoder().decode([ItemsModel].self, from: savedItems) {
            cartItems = decodedItems
        } else {
            cartItems = []
        }

        // Init history
        if let savedItems = UserDefaults.standard.data(forKey: "HistoryItem"),
           let decodedItems = try? JSONDecoder().decode([ItemsModel].self, from: savedItems) {
            history = decodedItems
        } else {
            history = []
        }

        // Init bookmarks
        if let savedItems = UserDefaults.standard.data(forKey: "BookmarkItem"),
           let decodedItems = try? JSONDecoder().decode([ItemsModel].self, from: savedItems) {
            bookmarks = decodedItems
        } else {
            bookmarks = []
        }
    }

    let featuredImages = [
        Image("f1"),
        Image("f2"),
        Image("f3")
    ]

    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var tabOpacity = true

    func removeBookmark(_ bookmark: ItemsModel) {
        if let index = bookmarks.firstIndex(where: { $0.id == bookmark.id }) {
            bookmarks.remove(at: index)
        }
    }

    func removeItem(_ item: ItemsModel) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems.remove(at: index)
        }
    }

    func addItem(_ item: ItemsModel) {
        // Check if item is already in the list
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            // Increase quantity if we have the item
            cartItems[index].availableQuantity += 1
        } else {
            // Else add item
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
            } // Update products array

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
    }

    func clearCart() {
        cartItems.removeAll()
    }
}
