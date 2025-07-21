//
//  Response.swift
//  EmbedSwiftUI
//
//  Created by Jonathan Mora on 20/07/25.
//
import SwiftUI

struct Response: Codable {
    let mensaje, advertencia: String
    let resultado: Resultado
}

struct Resultado: Codable {
    let paginacion: Paginacion
    let categoria: String
    let productos: [Producto]
}

struct Paginacion: Codable {
    let pagina, totalPaginas, totalRegistros, totalRegistrosPorPagina: Int
}

struct Producto: Codable, Identifiable {
    let id: String
    let idLinea: Int
    let codigoCategoria: CodigoCategoria
    let idModalidad, relevancia: Int
    let lineaCredito: String
    let pagoSemanalPrincipal, plazoPrincipal: Int
    let disponibleCredito: Bool
    let abonosSemanales: [AbonosSemanale]
    let sku, nombre: String
    let urlImagenes: [String]
    let precioRegular: Int
    let precioFinal, porcentajeDescuento: Double
    let descuento: Bool
    let precioCredito, montoDescuento: Double
}

struct AbonosSemanale: Codable {
    let plazo, montoAbono, montoDescuentoAbono, montoUltimoAbono: Int
    let montoFinalCredito, idPromocion, montoDescuentoElektra, montoDescuentoBanco: Int
    let precio, montoAbonoDigital: Int
}

enum CodigoCategoria: String, Codable {
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
    
    var iconName: String {
        switch self {
        case .c: return "cart"
        case .ma: return "music.note"
        case .tl: return "tv"
        }
    }
}
