//
//  EmpleadosViewModel.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 2/6/23.
//

import Foundation

final class EmpleadosViewModel: ObservableObject {
    let persistence = EmpleadosPersistence.shared
    
    @Published var empleados: [EmpleadosModel] = []
    
    init() {
        Task {
            let loadedEmpleados = await loadEmpleados()
            DispatchQueue.main.async {
                self.empleados = loadedEmpleados
            }
        }
    }
    
    private func loadEmpleados() async -> [EmpleadosModel] {
        do {
            return try await persistence.fetchEmpleados()
        } catch let error as NetworkErrors {
            print(error.rawValue)
        } catch {
            print(error)
        }
        
        return []
    }
}
