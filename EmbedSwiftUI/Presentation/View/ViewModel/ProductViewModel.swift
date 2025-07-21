//
//  ProductViewModel.swift
//  EmbedSwiftUI
//
//  Created by Jonathan Mora on 20/07/25.
//


import Foundation

class ProductViewModel: ObservableObject {
    @Published var productos: [Producto] = []
    @Published var errorMessage: String? = nil

    private let service: ProductService

    init(service: ProductService = ProductService()) {
        self.service = service
    }

    func loadProducts() {
        service.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let productos):
                    self?.productos = productos
                case .failure(let error):
                    self?.errorMessage = "Error al cargar productos"
                }
            }
        }
    }
}
