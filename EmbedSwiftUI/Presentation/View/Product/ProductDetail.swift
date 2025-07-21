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
                header
                Spacer()
                productInfo
                Spacer()
                actionButtons
            }
            .padding(24)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    private var header: some View {
        HStack {
            Spacer()
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 29, height: 29)
                    .foregroundStyle(.white)
            }
        }
    }

    private var productInfo: some View {
        VStack(spacing: 24) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(producto.sku)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    
                    Text(producto.nombre)
                        .font(.title3)
                        .foregroundStyle(.white)
                    
                    Text("$\(producto.precioFinal, specifier: "%.2f")")
                        .fontWeight(.regular)
                        .foregroundStyle(.colorText)
                        .padding(.top, 18)
                    
                    Text(producto.descuento ? "Con descuento" : "Sin descuento")
                        .font(.subheadline)
                        .foregroundColor(producto.descuento ? .green : .red)
                }
                Spacer()
                
                Text(producto.codigoCategoria.rawValue)
                    .fontWeight(.semibold)
                    .foregroundStyle(producto.codigoCategoria.color)
            }
            
            if let urlString = producto.urlImagenes.first,
               let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .mask(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }

    private var actionButtons: some View {
        HStack(spacing: 16) {
            Spacer()
            Button {
                // Acción
            } label: {
                Image(systemName: "cart.fill")
                    .font(.system(size: 30))
            }
            .customButtonStyle(.filled(color: .red))
        }
    }


}

#Preview {
    NavigationStack {
        ProductDetail(producto: .mock)
    }
}


#if DEBUG
extension Producto {
    static var mock: Producto {
        Producto(
            id: "1",
            idLinea: 101,
            codigoCategoria: .tl,
            lineaCredito: "Tecnología",
            disponibleCredito: true,
            sku: "TV-001",
            nombre: "Smart TV 55\" 4K UHD",
            urlImagenes: [
                "https://elektraqa.vteximg.com.br/arquivos/ids/1139675/34004283.jpg?v=637375228050530000"
            ],
            precioRegular: 15000,
            precioFinal: 11999.99,
            porcentajeDescuento: 20.0,
            descuento: true
        )
    }
}
#endif
