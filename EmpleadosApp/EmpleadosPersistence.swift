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

final class EmpleadosPersistence {
    static let shared = EmpleadosPersistence()
    
    let url = URL(string: "https://acacademy-employees-api.herokuapp.com/api/getEmpleados")
    
    private init() {}
    
    func fetchEmpleados() async throws -> [EmpleadosModel] {
        
        guard let url = url else { throw NetworkErrors.notFound }
        
        let (data, response) = try await URLSession.shared.data(from: url)

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
