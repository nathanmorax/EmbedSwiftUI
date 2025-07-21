//
//  ViewController.swift
//  EmbedSwiftUI
//
//  Created by Jonathan Mora on 20/07/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    private let viewModel = ProductViewModel()
    private var hostingController: UIHostingController<ProductList>?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadProducts()
        self.showSwiftUIView()
    }

    private func showSwiftUIView() {
        if let hc = hostingController {
            hc.willMove(toParent: nil)
            hc.view.removeFromSuperview()
            hc.removeFromParent()
        }

        let swiftUIView = ProductList(viewModel: viewModel)
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
