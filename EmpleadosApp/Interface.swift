//
//  Interface.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 3/6/23.
//

import Foundation

//tendremos los métodos de red

let mainURL = URL(string: "https://acacademy-employees-api.herokuapp.com/api")!
//MARK: a comentar baseURL

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

extension URL {
    static let getEmpleados = mainURL.appending(path: "getEmpleados")
}

extension URLRequest {
    
    static func get(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get.rawValue //accedes al enum para decirle el tipo, y así evitar los strings
        request.timeoutInterval = 10 //tiempo de espera para la llamada
        request.setValue("application/json", forHTTPHeaderField: "Accept") //para q solo aceptemos json del servidor
        return request
    }
}
