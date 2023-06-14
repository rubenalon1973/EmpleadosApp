//
//  EmpleadosAppApp.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 2/6/23.
//

import SwiftUI

@main
struct EmployeeApp: App {
//    la view principal al arrancar la app
    var body: some Scene {
        WindowGroup {
            listViewEmployee(employeeVm: EmpVM()) //por defecto coge el de producción
                .preferredColorScheme(.dark)
        }
    }
}
