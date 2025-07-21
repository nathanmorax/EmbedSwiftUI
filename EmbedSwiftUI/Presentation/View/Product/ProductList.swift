//
//  ProductList.swift
//  EmbedSwiftUI
//
//  Created by Jonathan Mora on 20/07/25.
//

import SwiftUI


struct ProductList: View {
    @ObservedObject var viewModel: ProductViewModel

    var groupedProducts: [CodigoCategoria: [Producto]] {
        Dictionary(grouping: viewModel.productos, by: { $0.codigoCategoria })
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(alignment: .leading, spacing: 16) {
                    
                    profile
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 32) {
                            ForEach(CodigoCategoria.allCases, id: \.self) { categoria in
                                if let productos = groupedProducts[categoria] {
                                    sectionView(for: categoria, productos: productos)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }

    @ViewBuilder
    func sectionView(for categoria: CodigoCategoria, productos: [Producto]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(categoria.title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.white)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(productos) { producto in
                        NavigationLink(destination: ProductDetail(producto: producto)) {
                            content(for: producto)
                                .frame(width: 260)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }

    func content(for producto: Producto) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if let urlString = producto.urlImagenes.first, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    ProgressView()
                        .frame(height: 140)
                }
            }

            Text(producto.nombre)
                .font(.headline)
                .foregroundColor(.white)

            Text("$\(producto.precioFinal, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .background(.backgroundCard)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private var profile: some View {
        HStack {
            Image("profile")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .shadow(radius: 22)

            Text("Nathan Mora")
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.top)
    }
}


#Preview {
    let mockProductos = [
        Producto(
            id: "p1",
            idLinea: 101,
            codigoCategoria: .c,
            lineaCredito: "Crédito Clásico",
            disponibleCredito: true,
            sku: "SKU001",
            nombre: "Audífonos Inalámbricos",
            urlImagenes: ["https://via.placeholder.com/150"],
            precioRegular: 1200,
            precioFinal: 899.99,
            porcentajeDescuento: 25.0,
            descuento: true
        ),
        Producto(
            id: "p2",
            idLinea: 102,
            codigoCategoria: .ma,
            lineaCredito: "Crédito Musical",
            disponibleCredito: true,
            sku: "SKU002",
            nombre: "Guitarra Eléctrica",
            urlImagenes: ["https://via.placeholder.com/150"],
            precioRegular: 6500,
            precioFinal: 5850.00,
            porcentajeDescuento: 10.0,
            descuento: true
        ),
        Producto(
            id: "p3",
            idLinea: 103,
            codigoCategoria: .tl,
            lineaCredito: "Crédito Hogar",
            disponibleCredito: false,
            sku: "SKU003",
            nombre: "Pantalla 4K",
            urlImagenes: ["https://via.placeholder.com/150"],
            precioRegular: 10000,
            precioFinal: 10000.00,
            porcentajeDescuento: 0.0,
            descuento: false
        )
    ]
    
    let mockViewModel = ProductViewModel()
    mockViewModel.productos = mockProductos
    
    return ProductList(viewModel: mockViewModel)
}
