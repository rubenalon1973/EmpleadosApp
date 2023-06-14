//
//  AddEmployeeVM.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 6/6/23.
//

import SwiftUI

//para cambiar el foco de un text a otro
enum AddEmployeeFields {
    case firstName, lastName, userName, email, address, zipcode
    //    func para tabular en los campos del enum en un orden
    mutating func next() { //es mutating pq el enum es com un struct y vamos a modif prop.
        switch self {
        case .firstName:
            self = .lastName
        case .lastName:
            self = .userName
        case .userName:
            self = .email
        case .email:
            self = .address
        case .address:
            self = .zipcode
        case .zipcode:
            self = .firstName
        }
    }
    //    func para tabular en los campos del enum en un orden inverso
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
        case .address:
            self = .email
        case .zipcode:
            self = .address
        }
    }
}
//lógica para la view de addEmployee
final class AddEmployeeVM: ObservableObject {
    let persistence = PersistenceEmp.shared
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var userName = ""
    @Published var email = ""
    @Published var address = ""
    @Published var zipcode = ""
    @Published var gender: GenderName = .female
    @Published var department: DepartmentName = .accounting
    
//    fx para pasarle los datos (q se rellenan en la view de AddEmpleado por el usuario), a la persistance donde esta la fx post para hacer el decode a la API
    func postEmployee() { 
        let newEmployee = NewEmployee(username: userName,
                                      firstName: firstName,
                                      lastName: lastName,
                                      email: email,
                                      address: address,
                                      avatar: "https://robohash.org/autconsequaturofficia.png",
                                      zipcode: zipcode,
                                      department: 2,
                                      gender: 2)
        Task { //para poder llamar a la fx al ser async
            await persistence.postEmployee(empleado: newEmployee)
        }
    }
}


