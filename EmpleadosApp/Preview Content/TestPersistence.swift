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
