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
    let lastName: String
    let avatar: URL
    let email: String
}
