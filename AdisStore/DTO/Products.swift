//
//  Products.swift
//  AdisStore
//
//  Created by user on 13/4/24.
//

import Foundation

struct Products: Codable {
    let meals: [Product]
}

struct Product: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}



struct Categories: Codable {
    let categories: [Category]
}


struct Category: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
