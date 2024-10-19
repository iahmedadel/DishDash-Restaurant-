//
//  IntermediaryModels.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 16/09/2024.
//

import Foundation
struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}

