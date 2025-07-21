//
//  ProductDetail.swift
//  EmbedSwiftUI
//
//  Created by Jonathan Mora on 20/07/25.
//
import SwiftUI

struct ProductDetail: View {
    @Environment(\.dismiss) private var dismiss
    let producto: Producto
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 29, height: 29)
                    }
                    .foregroundStyle(.gray)
                    
                }
                
                Spacer()
                
                VStack(spacing: 24) {
                    if let urlString = producto.urlImagenes.first, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    HStack {
                        Text(producto.nombre)
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Text("$\(producto.precioFinal, specifier: "%.2f")")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.white).opacity(0.7)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button {
                        // Acción
                    } label: {
                        Text("Buy Now")
                    }
                    .customButtonStyle(.outline(color: .white))
                    
                    Button {
                        // Acción
                    } label: {
                        Text("Add to Cart")
                    }
                    .customButtonStyle(.filled(color: .red))
                }
            }
            .padding(.all, 24)
        }
        .navigationBarBackButtonHidden(true)
    }
}
