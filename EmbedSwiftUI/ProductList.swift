//
//  ProductList.swift
//  EmbedSwiftUI
//
//  Created by Jonathan Mora on 20/07/25.
//

import SwiftUI


struct ProductList: View {
    let productos: [Producto]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(productos) { producto in
                            NavigationLink(destination: ProductDetail(producto: producto)) {
                                content(for: producto)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding()
                }
            }
        }
    }
    
    @ViewBuilder
    func content(for producto: Producto) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(producto.nombre)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(producto.descuento ? "Con descuento" : "Sin descuento")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Precio Final: $\(producto.precioFinal, specifier: "%.2f")")
                    .font(.title2)
                    .foregroundColor(.white)
                    .opacity(0.7)
                    .fontWeight(.regular)
            }
            
            Spacer()
            
            if let urlString = producto.urlImagenes.first, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    ProgressView()
                        .frame(width: 120, height: 120)
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .padding()
    }
}






