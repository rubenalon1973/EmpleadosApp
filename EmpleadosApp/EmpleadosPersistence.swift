//
//  EmpleadosPersistence.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 2/6/23.
//

import Foundation

enum NetworkErrors: String, Error {
    case badResponse = "Respuesta incorrecta servidor"
    case notFound = "No encontrada la URL"
    case failedToParseData = "Fallo en decode de datos"
}

protocol NetworkPersistence {
    
    func fetchEmpleados() async throws -> [EmpleadosModel] //en los protoc. solo van declaraciones
    
}

final class EmpleadosPersistence: NetworkPersistence {
    static let shared = EmpleadosPersistence()
        
    private init() {}
    
    func fetchEmpleados() async throws -> [EmpleadosModel] {

//        let (data, response) = try await URLSession.shared.data(from: .getEmpleados)
        let (data, response) = try await URLSession.shared.data(for: .get(url: .getEmpleados))

        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkErrors.badResponse }

        switch httpResponse.statusCode {
        case 200...299:
            return try JSONDecoder().decode([EmpleadosModel].self, from: data)
        case 400...450:
            throw NetworkErrors.notFound
        default:
            throw NetworkErrors.badResponse
        }
    }
}
