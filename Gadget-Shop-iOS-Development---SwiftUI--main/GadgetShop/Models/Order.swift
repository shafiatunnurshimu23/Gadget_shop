//
//  Order.swift
//  GadgetShop
//
//  Created by Md. Ibne Sina on 28/11/23.
//

import Foundation

struct Order {
    let id: String // The random ID
    let email: String
    let name: String
    let phone: String
    let total: Double
    let uid: String
    let products: [String: Any] // Dictionary for products
}
