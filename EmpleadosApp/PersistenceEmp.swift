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
//creamos protoc. para poder elegir de donde cargamos el json
protocol NetworkPersistence {
    func fetchEmpleados() async throws -> [EmpModel] //en los protoc. solo van declaraciones
}

final class PersistenceEmp: NetworkPersistence {
    static let shared = PersistenceEmp()
    
    private init() {}
    
    func fetchEmpleados() async throws -> [EmpModel] {
        
        //        let (data, response) = try await URLSession.shared.data(from: .getEmpleados) // -> URLSession tiene
        //        propiedad tupla que se le asigna otra tupla, y funcionan correlativos
        let (data, response) = try await URLSession.shared.data(for: .get(url: .getEmpleados)) //con urlreques
//        hacemos el response para poder saber el error y poderlo escalar hacia arriba
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkErrors.badResponse }//para tener el statusCode
        
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
//    fx para insertar empleado en la API ?????????????????????
    func postEmployee(empleado: NewEmployee) async {
//        ignoramos data no recibimos data
        let (_, response) = try! await URLSession.shared.data(for: .post(url: .postEmpleados, data: empleado))
        
        if let urlResponse = response as? HTTPURLResponse {
            #if DEBUG//con esto no sale en producción en modo Debug
            debugPrint(urlResponse.statusCode)//una opción q identificaría el error si lo hay,y dará un Int del error, pero no saldría reflejado en producción
            #endif //no se suele poner nunca ningún print ni debugPrint en codigo q se suba a producción
        }
    }
//    fx para bajar de la API los departamentos ?????????????????????
    func getDepartment() async throws -> [Departamento] {
        let (data, response) = try await URLSession.shared.data(for: .get(url: .getDepartamentos))
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkErrors.badResponse //cuando no pueda castear response a HTTPURLResponse
        }
        switch httpResponse.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode([Departamento].self, from: data)
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
