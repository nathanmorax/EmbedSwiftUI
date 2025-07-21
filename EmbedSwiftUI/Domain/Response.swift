//
//  Response.swift
//  EmbedSwiftUI
//
//  Created by Jonathan Mora on 20/07/25.
//
import SwiftUI

struct Response: Codable {
    let mensaje, advertencia: String?
    let resultado: Resultado?
}

struct Resultado: Codable {
    let categoria: String?
    let productos: [Producto]
}

struct Producto: Codable, Identifiable {
    let id: String
    let idLinea: Int
    let codigoCategoria: CodigoCategoria
    let lineaCredito: String?
    let disponibleCredito: Bool?
    let sku, nombre: String?
    let urlImagenes: [String]?
    let precioRegular: Int?
    let precioFinal, porcentajeDescuento: Double?
    let descuento: Bool?
}

enum CodigoCategoria: String, Codable, CaseIterable {
    case c = "C"
    case ma = "MA"
    case tl = "TL"
    
    var color: Color {
        switch self {
        case .c:
            return .blue
        case .ma:
            return .green
        case .tl:
            return .orange
        }
    }
    
    var title: String {
        switch self {
        case .c: return "Descubre"
        case .ma: return "Motos"
        case .tl: return "Celulares"
        }
    }
}
