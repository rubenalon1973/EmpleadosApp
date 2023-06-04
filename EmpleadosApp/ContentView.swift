//
//  ContentView.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 2/6/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var empleadosVm: EmpleadosViewModel //se actualiza gracias al published
    
    var body: some View {
        
        NavigationStack {
            List(empleadosVm.empleados) { empleado in
                HStack {
                    Text(empleado.firstName)
                }
            }
            .searchable(text: $search, placement: <#T##SearchFieldPlacement#>, prompt: <#T##Text?#>)
            .alert(isPresented: $empleadosVm.showError) { //este es el activador
                Alert(title: Text("An error gas ocurred"), message: Text(empleadosVm.errorMessage), dismissButton: .default(Text("Goit!")))
        }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(empleadosVm: .empleadosTest)
    }
}

