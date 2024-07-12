//
//  ItemsModel.swift
//  Tim Store
//
//  Created by Godwin IE on 05/07/2024.
//

import Foundation

struct ItemsModel: Codable, Identifiable {
    let id: String
    let name: String
    let description: String?
    let isAvailable: Bool
    let photos: [PhotoModel]
    let currentPrice: [PriceModel]

}
