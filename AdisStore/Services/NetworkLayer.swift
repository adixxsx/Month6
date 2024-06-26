//
//  NetworkLayer.swift
//  AdisStore
//
//  Created by user on 15/4/24.
//

import UIKit

struct NetworkLayer {
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    
    func fetchProducts(by categoryName: String, completion: @escaping (Result<[Product],Error>) -> Void) {
        let url = Constants.baseURL!.appendingPathComponent("filter.php")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [.init(name: "c", value: categoryName)]
        guard let url = components?.url else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response , error in
            
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                do{
                    let model = try decoder.decode(Products.self, from: data)
                    completion(.success(model.meals))
                }catch{
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
    
    func fetchCategorys(completion: @escaping (Result<[Category],Error>) -> Void) {
        let url = Constants.baseURL!.appendingPathComponent("categories.php")
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        guard let url = components?.url else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response , error in
            
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                do{
                    let model = try decoder.decode(Categories.self, from: data)
                    completion(.success(model.categories))
                }catch{
                    completion(.failure(error))
                }
            }
        }.resume()
        
    }
}
