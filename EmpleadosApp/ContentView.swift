//
//  ContentView.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 2/6/23.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var empleadosVm: EmpleadosViewModel //se actualiza la view gracias al published del vm
    @State var showEmp = false
    
    var body: some View {
        
        NavigationStack {
            List(empleadosVm.filteredEmpleadosModel) { empleado in //entramos a la var calculada del vm para acceder a la fx del search
                HStack {
                    Text(empleado.firstName)
                        .font( .title)
                        .bold()
                        .shadow(color: .white.opacity(70.0), radius: 10.0, x: 3, y: -3)
                    Spacer()
                    AsyncImage(url: empleado.avatar) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                    } placeholder: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                    }
                }
            }
            .searchable(text: $empleadosVm.search, placement: .automatic, prompt: "Búsqueda de empleado ")
            .alert(isPresented: $empleadosVm.showError) { //este es el activador
                Alert(title: Text("An error gas ocurred"), message: Text(empleadosVm.errorMessage), dismissButton: .default(Text("Goit!")))
            }
            .animation( .spring(), value: empleadosVm.search) //search al ser string es tipo equatable
            .navigationTitle("Empleados")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showEmp.toggle()
                    } label: {
                        Image(systemName: "plus") //símbolo +
                    }
                    .sheet(isPresented: $showEmp) {
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
    }
}

