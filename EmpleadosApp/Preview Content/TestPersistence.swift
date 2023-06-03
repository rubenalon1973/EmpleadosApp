//
//  TestPersistence.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 3/6/23.
//

import Foundation

extension URL {
    static let empleadosTest = Bundle.main.url(forResource: "EmpleadosTest", withExtension: "json")!
}


final class TestPersistence: NetworkPersistence {
    
    func fetchEmpleados() async throws -> [EmpleadosModel] {
        let data = try Data(contentsOf: .empleadosTest)
        return try JSONDecoder().decode([EmpleadosModel].self, from: data)
    }
}

extension EmpleadosViewModel {
    static let empleadosTest = EmpleadosViewModel(persistence: TestPersistence())
}
