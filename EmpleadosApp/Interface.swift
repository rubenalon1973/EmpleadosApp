//
//  Interface.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 3/6/23.
//

import Foundation

let mainURL = URL(string: "https://acacademy-employees-api.herokuapp.com/api")!

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

extension URL {
    static let getEmpleados = mainURL.appending(path: "getEmpleados")
    static let postEmpleados = mainURL.appending(path: "empleado")
    static let getDepartamentos = mainURL.appending(path: "getDepartamentos")
}

extension URLRequest {
    
    static func get(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get.rawValue
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    static func post<JSON: Codable>(url: URL, data: JSON) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = HTTPMethods.post.rawValue
        request.timeoutInterval = 30
        request.setValue("application/json; chartset=utf8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(data)
        return request
    }
}
