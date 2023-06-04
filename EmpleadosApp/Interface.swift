//
//  Interface.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 3/6/23.
//

import Foundation

//capa de configuración de llamadas de red, hay gente q lo mete todo en una clase lo de esta interface...reunido
let mainURL = URL(string: "https://acacademy-employees-api.herokuapp.com/api")! //url base

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}
//añadir nuestras url dentro del sist. para llamarlas más fácil
extension URL {
    static let getEmpleados = mainURL.appending(path: "getEmpleados")
}
//request: es una solicitud de más detalles, URL es una simple llamada
extension URLRequest {
    
    static func get(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get.rawValue //accedes al enum para decirle el tipo, y así evitar los strings
        request.timeoutInterval = 10 //tiempo de espera para la llamada
        request.setValue("application/json", forHTTPHeaderField: "Accept") //para q solo aceptemos json del servidor
        return request
    }
}
