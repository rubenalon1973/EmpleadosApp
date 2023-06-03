//
//  ContentView.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 2/6/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var empleadosVm: EmpleadosViewModel
    
    var body: some View {
        
        List(empleadosVm.empleados) { empleado in
            Text(empleado.firstName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(empleadosVm: .empleadosTest)
    }
}

