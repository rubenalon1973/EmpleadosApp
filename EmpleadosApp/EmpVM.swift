//
//  EmpleadosViewModel.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 2/6/23.
//

import Foundation

final class EmpVM: ObservableObject {
    let persistence: NetworkPersistence
    
    @Published var empleados: [EmpModel] = []
    @Published var errorMessage = ""
    @Published var showError = false
    @Published var search = ""
    @Published var department: [Department] = []
    
    var filteredEmpleadosModel: [EmpModel] {
        empleados.filter { empleado in
            searchFilter(empleado: empleado)
        }
    }
    
    init(persistence: NetworkPersistence = PersistenceEmp.shared) {
        self.persistence = persistence
        Task {
            await loadEmpleados()
        }
    }
    
    @MainActor
    private func loadEmpleados() async {
        do {
            empleados = try await persistence.fetchEmpleados()
        } catch let error as NetworkErrors {
            showError = true
            errorMessage = error.rawValue
            print(error.rawValue)
        } catch {
            showError = true
            errorMessage = error.localizedDescription
            print(error)
        }
    }
    
    private func searchFilter(empleado: EmpModel) -> Bool {
        search.isEmpty || empleado.firstName.lowercased().contains(search.lowercased())
    }
}
