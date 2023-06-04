//
//  EmpleadosAppApp.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 2/6/23.
//

import SwiftUI

@main
struct EmpleadosAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(empleadosVm: EmpleadosViewModel()) //por defecto coge el de producción
        }
    }
}
