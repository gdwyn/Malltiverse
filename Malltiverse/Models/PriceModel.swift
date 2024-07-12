//
//  PriceModel.swift
//  Tim Store
//
//  Created by Godwin IE on 05/07/2024.
//

import Foundation

struct PriceModel: Codable {
    let NGN: [PriceValue]
}

enum PriceValue: Codable {
    case double(Double)
    case array([Double])
    case empty

    init(from decoder: Decoder) throws {
        if let doubleValue = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(doubleValue)
            return
        }
        if let arrayValue = try? decoder.singleValueContainer().decode([Double].self) {
            self = .array(arrayValue)
            return
        }
        self = .empty
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let value):
            try container.encode(value)
        case .array(let value):
            try container.encode(value)
        case .empty:
            // Encode as an empty array or handle as appropriate for your use case
            try container.encode([Double]())
        }
    }
}
