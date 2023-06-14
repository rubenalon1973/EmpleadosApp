//
//  TestPersistence.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 3/6/23.
//

import Foundation

//nada de esto va en la app, al arrancar ignora la preview content

//Uniform resource locator URL, no se hace llamada a red, sino en local, creado por nosotros
extension URL {
    static let empleadosTest = Bundle.main.url(forResource: "EmpleadosTest", withExtension: "json")!
}

final class TestPersistence: NetworkPersistence {
    
    func fetchEmpleados() async throws -> [EmpModel] {
        let data = try Data(contentsOf: .empleadosTest) //decodifica a bytes en data
        return try JSONDecoder().decode([EmpModel].self, from: data) // va rellenando de data
    }
}

extension EmpVM {
    static let empleadosTest = EmpVM(persistence: TestPersistence())
}

extension EmpModel {
    static let testEmpleado = EmpModel(id: 5, firstName: "David", username: "ndohertyj", lastName: "Doherty", avatar: URL(string: "https://robohash.org/enimsolutaperferendis.png")!, email: "ndohertyj@mysql.com", address: "97 Transport Crossing", department: Departamento(id: 5, name: .engineering), gender: Genero(id: 2, gender: .female))
}
