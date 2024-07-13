//
//  FetchProducts.swift
//  Tim Store
//
//  Created by Godwin IE on 05/07/2024.
//

import Foundation

func getProducts() async throws -> ProductsModel {
    
    let endpoint = "https://api.timbu.cloud/products?organization_id=3139238bbeb44dfab0934d6a6ab61954&Appid=TX6XQRR0UP6ACS8&Apikey=e96e405e9c534eaeb1fab06f7ac2c90420240704204303045798"
    
    guard let url = URL(string: endpoint) else {
        print("Invalid URL")
        throw AppErrors.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url) // GET request
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw AppErrors.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let productsModel = try decoder.decode(ProductsModel.self, from: data)
        return productsModel
    } catch {
        print(error.localizedDescription)
        throw AppErrors.invalidData
    }
    
}
