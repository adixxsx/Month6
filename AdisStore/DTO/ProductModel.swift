//
//  ProductModel.swift
//  AdisStore
//
//  Created by user on 11/4/24.
//

import Foundation

struct Productts: Codable {
    let products: [Productt]
}

struct Productt: Codable {
    let title: String
}
