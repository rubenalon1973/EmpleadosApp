//
//  EmpleadosModel.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 2/6/23.
//

import Foundation


struct EmpleadosModel: Codable, Identifiable {
    let id: Int
    let firstName: String
    let username: String
    let lastName: String
    let avatar: URL
    let email: String
    let department: Departamento
    let gender: Genero
    
    var fullName: String {
        "\(lastName), \(firstName)"
    }
    
}
struct Departamento: Codable, Identifiable {
    let id: Int
    let name: NombreDepartamento
}

enum NombreDepartamento: String, Codable, CaseIterable, Identifiable {
    var id: String{ UUID().uuidString }
    case accounting = "Accounting"
    case businessDevelopment = "Business Development"
    case engineering = "Engineering"
    case humanResources = "Human Resources"
    case legal = "Legal"
    case marketing = "Marketing"
    case productManagement = "Product Management"
    case researchAndDevelopment = "Research and Development"
    case sales = "Sales"
    case services = "Services"
    case support = "Support"
    case training = "Training"
}

struct Genero: Codable, Identifiable {
    let id: Int
    let gender: NombreGenero
}

enum NombreGenero: String, Codable {
    case female = "Female"
    case male = "Male"
}
