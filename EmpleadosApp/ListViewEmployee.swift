//
//  ContentView.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 2/6/23.
//

import SwiftUI

struct listViewEmployee: View {
    @ObservedObject var employeeVm: EmpVM
    @State var showEmp = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(DepartmentName.allCases) { dpto in //conformamos caseIterable en struct
                    Section(dpto.rawValue) {
                        //para buscar los empleados dentro de la sección
                        ForEach(employeeVm.filteredEmpleadosModel) { empleado in
                            if empleado.department.name == dpto {
                                CellEmployeeView(empleado: empleado)
                            }
                        }
                    }
                }
            }
            .searchable(text: $employeeVm.search, placement: .automatic, prompt: "Búsqueda de empleado ")
            .alert(isPresented: $employeeVm.showError) { //este es el activador
                Alert(title: Text("An error has ocurred"), message: Text(employeeVm.errorMessage), dismissButton: .default(Text("Go it!")))
            }
            .animation( .spring(), value: employeeVm.search) //search al ser string es tipo equatable
            .navigationTitle("Employees")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddEmployeeView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct listViewEmpleado_Previews: PreviewProvider {
    static var previews: some View {
        listViewEmployee(employeeVm: .empleadosTest)
            .preferredColorScheme(.dark)
    }
}


