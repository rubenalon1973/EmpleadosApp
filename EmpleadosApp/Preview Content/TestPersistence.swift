//
//  TestPersistence.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 3/6/23.
//

import Foundation

extension URL {
    static let empleadosTest = Bundle.main.url(forResource: "EmployeeTest", withExtension: "json")!
}

final class TestPersistence: NetworkPersistence {
    
    func fetchEmpleados() async throws -> [EmpModel] {
        let data = try Data(contentsOf: .empleadosTest)
        return try JSONDecoder().decode([EmpModel].self, from: data)
    }
}

extension EmpVM {
    static let empleadosTest = EmpVM(persistence: TestPersistence())
}

extension EmpModel {
    static let testEmpleado = EmpModel(id: 5, firstName: "David", username: "ndohertyj", lastName: "Doherty", avatar: URL(string: "https://robohash.org/enimsolutaperferendis.png")!, email: "ndohertyj@mysql.com", address: "97 Transport Crossing", department: Department(id: 5, name: .engineering), gender: Gender(id: 2, gender: .female))
}
