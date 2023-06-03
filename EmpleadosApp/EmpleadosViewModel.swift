//
//  EmpleadosViewModel.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 2/6/23.
//

import Foundation

final class EmpleadosViewModel: ObservableObject {
    let persistence: NetworkPersistence
    
    @Published var empleados: [EmpleadosModel] = []
    
//    para poder elegir el persistence q queramos, por defecto el de producción
    init(persistence: NetworkPersistence = EmpleadosPersistence.shared) {
        self.persistence = persistence
        Task {
            await loadEmpleados()
        }
    }
    
    //para mover al hilo principal, acordarse cdo hagamos llamadas a red
    @MainActor
    private func loadEmpleados() async {
        do {
            empleados = try await persistence.fetchEmpleados()
        } catch let error as NetworkErrors {
            print(error.rawValue)
        } catch {
            print(error)
        }
    }
}
