//
//  APIService.swift
//  EmbedSwiftUI
//
//  Created by Jonathan Mora on 20/07/25.
//

struct Response: Codable {
    let mensaje, advertencia: String
    let resultado: Resultado
}

// MARK: - Resultado
struct Resultado: Codable {
    let paginacion: Paginacion
    let categoria: String
    let productos: [Producto]
}

// MARK: - Paginacion
struct Paginacion: Codable {
    let pagina, totalPaginas, totalRegistros, totalRegistrosPorPagina: Int
}

// MARK: - Producto
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

// MARK: - AbonosSemanale
struct AbonosSemanale: Codable {
    let plazo, montoAbono, montoDescuentoAbono, montoUltimoAbono: Int
    let montoFinalCredito, idPromocion, montoDescuentoElektra, montoDescuentoBanco: Int
    let precio, montoAbonoDigital: Int
}

enum CodigoCategoria: String, Codable {
    case c = "C"
    case ma = "MA"
    case tl = "TL"
}

import Foundation

class ProductService {
    func fetchProducts(completion: @escaping (Result<[Producto], Error>) -> Void) {
        guard let url = URL(string: "http://alb-dev-ekt-875108740.us-east-1.elb.amazonaws.com/apps/moviles/caso-practico/plp") else {
            completion(.failure(NSError(domain: "URL inválida", code: 0)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "Sin datos", code: 0)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(decoded.resultado.productos))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
