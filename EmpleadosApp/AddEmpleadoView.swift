//
//  AddEmpleado.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 4/6/23.
//

import SwiftUI

struct AddEmpleadoView: View {
    @ObservedObject var vm = AddEmployeeVM()//puente a esta view
    @FocusState var focusField: AddEmployeeFields? //enum VM
    @State var name = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    Text("FirstName")
                        .font( .headline)
                    TextField("Enter first name", text: $vm.firstName) //state var
                        .textContentType( .name)//propiedad del sist para dif formatos(ej keyboardType)
                        .textInputAutocapitalization( .words)//pone la 1ª en mayus.
                        .focused($focusField, equals: .firstName)// el del enum
                        .submitLabel( .next)//cambia el name del return
                        .onSubmit {//crea una acción
                            focusField?.next()
                        }
                }
                VStack(alignment: .leading) {
                    Text("UserName")
                        .font( .headline)
                    TextField("Enter userName", text: $vm.userName)
                        .textContentType( .username)
                        .textInputAutocapitalization( .none)//diferent al ant, pq puede ser en minúsc.
                        .autocorrectionDisabled()//deshabilita autocorrec, viene x defect en TexField el autocorrec.
                        .focused($focusField, equals: .userName)
                        .submitLabel( .next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                VStack(alignment: .leading) {
                    Text("LastName")
                        .font( .headline)
                    TextField("Enter lastName", text: $vm.lastName)
                        .textContentType( .username)
                        .textInputAutocapitalization( .words)
                        .focused($focusField, equals: .lastName)
                        .submitLabel( .next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                VStack(alignment: .leading) {
                    Text("Email")
                        .font( .headline)
                    TextField("Enter email", text: $vm.email)
                        .textContentType( .username)
                        .textInputAutocapitalization( .never)
                        .keyboardType( .emailAddress)//teclado con temas de email
                        .focused($focusField, equals: .email)
                        .submitLabel( .next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                //MARK: Opciones a revisar en documentación
                //                DisclosureGroup // para crear celdas q tengan contenido dentro
                //                LabeledContent("Gender") { //Si trabajamos con pickers fuera de formularios, sino no coge el label,hay q utilizar este.
                //                }
                //Creamos pickers para desplegar opciones, para recorrer colecciones
                Picker(selection: $vm.gender) {//picker hashable, como un string
                    ForEach(NombreGenero.allCases) { gender in
                        Text(gender.rawValue)
                            .tag(gender)
                    }
                } label: {
                    Text("Gender")
                }
                Picker(selection: $vm.department) {
                    ForEach(NombreDepartamento.allCases) { department in
                        Text(department.rawValue)//también podemos poner una image, o un label con systemImage xej
                            .tag(department)
                    }
                } label: {
                    Text("Department")
                }
                
                Button {
//                    $vm.postEmployee
                } label: {
                    Text("Save")
                }
                .buttonStyle( .borderedProminent)
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowBackground(Color.clear)
                .padding()

            }
            .navigationTitle("New Employee")
        }
    }
}

struct AddEmpleadoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddEmpleadoView()
                .preferredColorScheme(.dark)
        }
    }
}
