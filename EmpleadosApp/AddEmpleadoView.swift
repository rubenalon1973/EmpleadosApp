//
//  AddEmpleado.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 4/6/23.
//

import SwiftUI

struct AddEmpleadoView: View {
    @State var name = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    Text("FirstName")
                    TextField("Name", text: $name)
                        .textContentType( .username)
                        .textInputAutocapitalization( .words)
                }
            }
        }
    }
}

struct AddEmpleadoView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmpleadoView()
    }
}
