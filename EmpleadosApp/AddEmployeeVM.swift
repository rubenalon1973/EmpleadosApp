//
//  AddEmployeeVM.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 6/6/23.
//

import SwiftUI

enum AddEmployeeFields {
    case firstName, lastName, userName, email, address, zipcode
    
    mutating func next() {
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
    
    mutating func prev() {
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

final class AddEmployeeVM: ObservableObject {
    let persistence = PersistenceEmp.shared
    
    @Published var department: Department.ID = 1
    @Published var departaments = [Department]()
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var userName = ""
    @Published var email = ""
    @Published var address = ""
    @Published var zipcode = ""
    @Published var gender: GenderName = .female
    @Published var showWrongFieldAlert = false
    @Published var wrongFieldMessage = ""
    @Published var dismissView = false
    
    init() {
        Task { @MainActor in
            departaments = try await persistence.getDepartment()
        }
    }
    
    func postEmployee() {
        let emailRegex = try?
        Regex(#"(?:[a-z0-9!#$%&'+/=?^_`{|}~-]+(?:.[a-z0-9!#$%&'+/=?^_`{|}~-]+)|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\[\x01-\x09\x0b\x0c\x0e-\x7f])")@(?:(?:[a-z0-9](?:[a-z0-9-][a-z0-9])?.)+[a-z0-9](?:[a-z0-9-][a-z0-9])?|[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])).){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\[\x01-\x09\x0b\x0c\x0e-\x7f])+)])"#)
        
        if firstName.isEmpty {
            wrongFieldMessage = "First name cannot empty"
        }
        
        if lastName.isEmpty {
            wrongFieldMessage = "Last name cannot empty"
        }
        
        if userName.isEmpty || userName.count < 6 {
            wrongFieldMessage = "Username cannot be empty and must be 8 characters or longer"
        }
        
        if email.isEmpty || !((try? emailRegex?.wholeMatch(in: email)) == nil) {
            wrongFieldMessage = "Email cannot be empty or empty or it has bad format"
        }
        
        if address.isEmpty {
            wrongFieldMessage = "Address cannot be empty"
        }
        
        if zipcode.isEmpty {
            wrongFieldMessage = "Zipcode cannot be empty"
        }
        
        if wrongFieldMessage.isEmpty {
            let newEmployee = NewEmployee(username: userName,
                                          firstName: firstName,
                                          lastName: lastName,
                                          email: email,
                                          address: address,
                                          avatar: "https://robohash.org/autconsequaturofficia.png",
                                          zipcode: zipcode,
                                          department: department,
                                          gender: gender.id)
            dismissView.toggle()
            
            Task {
                await persistence.postEmployee(empleado: newEmployee)
            }
        } else {
            showWrongFieldAlert.toggle()
        }
    }
    
    func cleanFields() {
        firstName = ""
        lastName = ""
        userName = ""
        email = ""
        address = ""
        zipcode = ""
    }
}


