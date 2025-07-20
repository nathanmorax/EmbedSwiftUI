//
//  ViewController.swift
//  EmbedSwiftUI
//
//  Created by Jonathan Mora on 20/07/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    private var productos: [Producto] = []

    private var hostingController: UIHostingController<ProductList>?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadProducts()
    }

    private func loadProducts() {
        ProductService().fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let productos):
                    self?.productos = productos
                    self?.showSwiftUIView()
                case .failure(let error):
                    print("Error al cargar productos:", error)
                    // Aquí puedes mostrar un error visual si quieres
                }
            }
        }
    }

    private func showSwiftUIView() {
        // Si ya existe un hosting, remuévelo
        if let hc = hostingController {
            hc.willMove(toParent: nil)
            hc.view.removeFromSuperview()
            hc.removeFromParent()
        }

        let swiftUIView = ProductList(productos: productos)
        let hc = UIHostingController(rootView: swiftUIView)
        hostingController = hc

        addChild(hc)
        view.addSubview(hc.view)

        hc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hc.view.topAnchor.constraint(equalTo: view.topAnchor),
            hc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        hc.didMove(toParent: self)
    }
}



