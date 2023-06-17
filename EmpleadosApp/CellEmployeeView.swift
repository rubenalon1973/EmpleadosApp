//
//  CeldaEmpleadoView.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 5/6/23.
//

import SwiftUI

struct CellEmployeeView: View {
    let empleado: EmpModel
    
    var body: some View {
        HStack {
            VStack() {
                Text(empleado.fullName)
                    .font( .title2)
                    .colorMultiply( .mint)
                    .bold()
                    .shadow(color: .white.opacity(70.0), radius: 10.0, x: 3, y: -3)
                Text(empleado.email)
                    .font( .caption)
            }
            Spacer()
            AsyncImage(url: empleado.avatar) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            } placeholder: {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
        }
    }
}

struct CellEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        CellEmployeeView(empleado: .testEmpleado)
            .padding() //para separarlo de la izq, en producción el list se encarga de ello
            .preferredColorScheme(.dark)
    }
}
