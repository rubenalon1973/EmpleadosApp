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
    case unknow = "Error desconocido"
    case badParse = "Fallo en el parseo"
}

protocol NetworkPersistence {
    func fetchEmpleados() async throws -> [EmpModel] //en los protoc. solo van declaraciones
}

final class PersistenceEmp: NetworkPersistence {
    static let shared = PersistenceEmp()
    
    private init() {}
    
    func fetchEmpleados() async throws -> [EmpModel] {
        let (data, response) = try await URLSession.shared.data(for: .get(url: .getEmpleados))
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkErrors.badResponse }
        
        switch httpResponse.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode([EmpModel].self, from: data)
            } catch {
                throw NetworkErrors.failedToParseData
            }
        case 400...450:
            throw NetworkErrors.notFound
        case 500...550:
            throw NetworkErrors.notFound
        default:
            throw NetworkErrors.unknow
        }
    }
    
    func postEmployee(empleado: NewEmployee) async {
        let (_, response) = try! await URLSession.shared.data(for: .post(url: .postEmpleados, data: empleado))
        
        if let urlResponse = response as? HTTPURLResponse {
#if DEBUG
            debugPrint(urlResponse.statusCode)
#endif
        }
    }
    
    func getDepartment() async throws -> [Department] {
        let (data, response) = try await URLSession.shared.data(for: .get(url: .getDepartamentos))
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkErrors.badResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode([Department].self, from: data)
            } catch {
                throw NetworkErrors.failedToParseData
            }
        case 400...450:
            throw NetworkErrors.notFound
        case 500...550:
            throw NetworkErrors.notFound
        default:
            throw NetworkErrors.unknow
        }
    }
}
