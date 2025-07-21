//
//  APIService.swift
//  EmbedSwiftUI
//
//  Created by Jonathan Mora on 20/07/25.
//

import Foundation

class ProductService {
    func fetchProducts(completion: @escaping (Result<[Producto], Error>) -> Void) {
        guard let url = URL(string: "http://alb-dev-ekt-875108740.us-east-1.elb.amazonaws.com/apps/moviles/caso-practico/plp") else {
            completion(.failure(NSError(domain: "URL inválida", code: 0)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "Sin datos", code: 0)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(decoded.resultado.productos))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
