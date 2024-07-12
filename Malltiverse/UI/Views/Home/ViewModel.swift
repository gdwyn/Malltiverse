//
//  ViewModel.swift
//  Tim Store
//
//  Created by Godwin IE on 06/07/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var products: [ItemsModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
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
