//
//  AddEmpleado.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 4/6/23.
//

import SwiftUI
//vista para q el usuario rellene los campos con sus datos y el su vm actualice esta propia view
struct AddEmployeeView: View {
    @ObservedObject var vm = AddEmployeeVM()//puente a esta view
    @FocusState var focusField: AddEmployeeFields?
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
                        .textContentType( .name)
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
                        .textContentType( .emailAddress)
                        .textInputAutocapitalization( .never)
                        .keyboardType( .emailAddress)//teclado con temas de email
                        .focused($focusField, equals: .email)
                        .submitLabel( .next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("Address")
                        .font( .headline)
                    TextField("Enter address", text: $vm.address)
                        .textContentType( .addressCityAndState)
                        .textInputAutocapitalization( .never)
                        .keyboardType( .numbersAndPunctuation)//teclado con temas de email
                        .focused($focusField, equals: .address)
                        .submitLabel( .next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("Zipcode")
                        .font( .headline)
                    TextField("Enter zipcode", text: $vm.zipcode)
                        .textContentType( .postalCode)
                        .textInputAutocapitalization( .never)
                        .keyboardType( .numberPad)//teclado con temas de zipcode
                        .focused($focusField, equals: .zipcode)
                        .submitLabel( .next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                //MARK: Opciones a revisar en documentación
                //                DisclosureGroup // para crear celdas q tengan contenido dentro
                //                LabeledContent("Gender") { //Si trabajamos con pickers fuera de formularios, si no no coge el label,hay q utilizar este.
                //                }
                //Creamos pickers para desplegar opciones, para recorrer colecciones
                Picker(selection: $vm.gender) {//picker hashable, como un string
                    ForEach(GenderName.allCases) { gender in
                        Text(gender.rawValue)
                            .tag(gender)
                    }
                } label: {
                    Text("Gender")
                }
                
                Picker(selection: $vm.department) {
                    ForEach(vm.departaments) { department in
                        Text(department.name.rawValue)//también podemos poner una image, o un label con systemImage xej
                            .tag(department.id)
                    }
                } label: {
                    Text("Department")
                }
            }
        }
        .textFieldStyle(.roundedBorder)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    vm.postEmployee()
                    if vm.dismissView {
                        dismiss()
                        vm.cleanFields()
                    }
                } label: {
                    Text("Save")
                }
                .alert(isPresented: $vm.showWrongFieldAlert) {
                    Alert(title: Text("Empty field"), message: Text(vm.wrongFieldMessage))
                }
            }
        }
        .navigationTitle("New Employee")
    }
}

struct AddEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddEmployeeView()
                .preferredColorScheme(.dark)
        }
    }
}
