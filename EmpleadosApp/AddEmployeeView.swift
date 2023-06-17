//
//  AddEmpleado.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 4/6/23.
//

import SwiftUI

struct AddEmployeeView: View {
    @ObservedObject var vm = AddEmployeeVM()
    @FocusState var focusField: AddEmployeeFields?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section {
                
                VStack(alignment: .leading) {
                    Text("FirstName")
                        .font( .headline)
                    TextField("Enter first name", text: $vm.firstName)
                        .textContentType( .name)
                        .textInputAutocapitalization( .words)
                        .focused($focusField, equals: .firstName)
                        .submitLabel( .next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("UserName")
                        .font( .headline)
                    TextField("Enter userName", text: $vm.userName)
                        .textContentType( .username)
                        .textInputAutocapitalization( .none)
                        .autocorrectionDisabled()
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
                        .keyboardType( .emailAddress)
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
                        .keyboardType( .numbersAndPunctuation)
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
                        .keyboardType( .numberPad)
                        .focused($focusField, equals: .zipcode)
                        .submitLabel( .next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                
                Picker(selection: $vm.gender) {
                    ForEach(GenderName.allCases) { gender in
                        Text(gender.rawValue)
                            .tag(gender)
                    }
                } label: {
                    Text("Gender")
                }
                
                Picker(selection: $vm.department) {
                    ForEach(vm.departaments) { department in
                        Text(department.name.rawValue)
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
