//
//  EmpleadosAppApp.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 2/6/23.
//

import SwiftUI

@main
struct EmployeeApp: App {
    var body: some Scene {
        WindowGroup {
            listViewEmployee(employeeVm: EmpVM())
                .preferredColorScheme(.dark)
        }
    }
}
