//
//  AddEmployeeVM.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 6/6/23.
//

import SwiftUI

//para cambiar el foco de un text a otro
enum AddEmployeeFields {
    case firstName, lastName, userName, email
//    func para tabular en los campos del enum
    mutating func next() { //es mutating pq el enum es com un struct y vamos a modif prop.
        switch self {
        case .firstName:
            self = .lastName
        case .lastName:
            self = .userName
        case .userName:
            self = .email
        case .email:
            self = .firstName
        }
    }
    mutating func prev() { //es mutating pq el enum es com un struct y vamos a modif prop.
        switch self {
        case .firstName:
            self = .email
        case .lastName:
            self = .firstName
        case .userName:
            self = .lastName
        case .email:
            self = .userName
        }
    }
}


final class AddEmployeeVM: ObservableObject {
    let persistence = PersistenceEmp.shared
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var userName = ""
    @Published var email = ""
    @Published var gender: NombreGenero = .female
    @Published var department: NombreDepartamento = .accounting
    
    
//    func postEmployee() {
//        let newEmployee = EmpModel(id: 2000,
//                                   firstName: firstName,
//                                   username: userName,
//                                   lastName: lastName,
//                                   avatar: URL(string: "https://robohash.org/voluptatemvoluptatemnon.png")!,
//                                   email: email,
//                                   department: Departamento(id: department.hashValue, name: department),
//                                   gender: Genero(id: gender.hashValue, gender: gender))
//        Task {
//            await persistence.postEmployee(empleado: newEmployee)
//        }
//    }
}


