//
//  CeldaEmpleadoView.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 5/6/23.
//

import SwiftUI

struct CeldaEmpleadoView: View {
    
    let empleado: EmpleadosModel
    
    var body: some View {
        NavigationStack {
            HStack {
                VStack() {
                    Text(empleado.fullName)
                        .font( .callout)
                        .bold()
                        .shadow(color: .white.opacity(70.0), radius: 10.0, x: 3, y: -3)
                    Text(empleado.email)
                        .font( .caption2)
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
}



struct CeldaEmpleadoView_Previews: PreviewProvider {
    static var previews: some View {
        CeldaEmpleadoView(empleado: .testEmpleado)
            .padding() //para separarlo de la izq, en producción el list se encarga de ello
    }
}
