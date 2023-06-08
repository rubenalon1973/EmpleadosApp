//
//  ContentView.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 2/6/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var empleadosVm: EmpVM //se actualiza la view gracias al published del vm
    @State var showEmp = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(NombreDepartamento.allCases) { dpto in //conformamos caseIterable en struct
                    Section(dpto.rawValue) {
                        //para buscar los empleados dentro de la sección
                        ForEach(empleadosVm.filteredEmpleadosModel) { empleado in
                            if empleado.department.name == dpto {
                                CeldaEmpleadoView(empleado: empleado)
                            }
                        }
                    }
                }
            }
            .searchable(text: $empleadosVm.search, placement: .automatic, prompt: "Búsqueda de empleado ")
            .alert(isPresented: $empleadosVm.showError) { //este es el activador
                Alert(title: Text("An error has ocurred"), message: Text(empleadosVm.errorMessage), dismissButton: .default(Text("Go it!")))
            }
            .animation( .spring(), value: empleadosVm.search) //search al ser string es tipo equatable
            .navigationTitle("Employees")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showEmp.toggle()
                    } label: {
                        Image(systemName: "plus") //símbolo +
                    }
                    .sheet(isPresented: $showEmp) { //despliega una modalView
                        showEmp = false
                    } content: {
                        AddEmpleadoView()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(empleadosVm: .empleadosTest)
            .preferredColorScheme(.dark)
    }
}


