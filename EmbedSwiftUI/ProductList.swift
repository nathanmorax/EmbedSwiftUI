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
        
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(productos) { producto in
                        content(for: producto)
                    }
                }
                .padding()
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

                
                Text("Grown in water without soil. Easy to care for and perfect for indoor decor.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(producto.precioFinal.description)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            Image("product.1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 120)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .padding()
    }
    
    
}

struct ProductDetail: View {
    
    var body: some View {
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 29, height: 29)
                    }
                    .foregroundStyle(.gray)
                    
                }
                
                Spacer()
                
                VStack(spacing: 24) {
                    Image("product.1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    
                    HStack {
                        Text("Water-Grown Plant")
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Text("$20.00")
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
    }
}

enum CustomButtonType {
    case outline(color: Color)
    case filled(color: Color)
    
}

struct CustomButtonModifier: ViewModifier {
    let type: CustomButtonType
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight: 44)
            .background(backgroundFor(type))
            .foregroundStyle(foregroundFor(type))
            .overlay(overlayFor(type))
            .cornerRadius(8)
    }
    
    private func backgroundFor(_ type: CustomButtonType) -> Color {
        switch type {
        case .outline:
            return Color.clear
        case .filled(let color):
            return color
        }
    }
    
    private func foregroundFor(_ type: CustomButtonType) -> Color {
        switch type {
        case .outline(let color):
            return color
        case .filled:
            return .white
        }
    }
    
    @ViewBuilder
    private func overlayFor(_ type: CustomButtonType) -> some View {
        switch type {
        case .outline(let color):
            RoundedRectangle(cornerRadius: 8)
                .stroke(color, lineWidth: 2)
        case .filled:
            EmptyView()
        }
    }
}

extension View {
    func customButtonStyle(_ type: CustomButtonType) -> some View {
        self.modifier(CustomButtonModifier(type: type))
    }
}

