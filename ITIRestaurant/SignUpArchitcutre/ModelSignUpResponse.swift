//
//  SignUpResponse.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 16/09/2024.
//

import Foundation
struct SignUpResponse: Codable {
    let status: Bool
    let message: String
    let token: String? 
}
