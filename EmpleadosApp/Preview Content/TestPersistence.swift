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
    
    func fetchEmpleados() async throws -> [EmpleadosModel] {
        let data = try Data(contentsOf: .empleadosTest) //decodifica a bytes en data
        return try JSONDecoder().decode([EmpleadosModel].self, from: data) // va rellenando de data
    }
}

extension EmpleadosViewModel {
    static let empleadosTest = EmpleadosViewModel(persistence: TestPersistence())
}

extension EmpleadosModel {
    static let testEmpleado = EmpleadosModel(id: 5, firstName: "David", username: "ndohertyj", lastName: "Doherty", avatar: URL(string: "https://robohash.org/enimsolutaperferendis.png")!, email: "ndohertyj@mysql.com", department: Departamento(id: 5, name: .engineering), gender: Genero(id: 2, gender: .female))
}
