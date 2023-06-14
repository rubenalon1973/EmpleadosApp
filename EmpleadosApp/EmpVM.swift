//
//  EmpleadosViewModel.swift
//  EmpleadosApp
//
//  Created by Ruben Alonso on 2/6/23.
//

import Foundation

final class EmpVM: ObservableObject {
    let persistence: NetworkPersistence //para poder elegir de donde coger los datos
    
    @Published var empleados: [EmpModel] = [] // publisher envía info x tubería a la view cada vez q empleados cambia, gracias al obsevedObject
    @Published var errorMessage = ""
    @Published var showError = false
    @Published var search = ""
    @Published var department: [Department] = []
    
    var filteredEmpleadosModel: [EmpModel] {
        empleados.filter { empleado in
            searchFilter(empleado: empleado)
        }
    }
    
//    MARK: INYECCION DE DEPENDENCIAS
//    para poder elegir el persistence q queramos, por defecto el de producción, pero te da opción de llamar al que quieras(el de test)
    init(persistence: NetworkPersistence = PersistenceEmp.shared) {
        self.persistence = persistence
        Task {
            await loadEmpleados()
        }
    }
    
    //para mover al hilo principal, acordarse cdo hagamos llamadas a red con Async-await (actor)
    @MainActor
    private func loadEmpleados() async { //sino la vamos a utilizar más, la ponemos private(o en un proyecto común para q sólo se utilice en esta class
        do {
            empleados = try await persistence.fetchEmpleados()
        } catch let error as NetworkErrors {
            showError = true //para que nos muestre el alert
            errorMessage = error.rawValue //pondrá el string del error q sea  en errorMessage
            print(error.rawValue)
        } catch { //este catch lo tenemos para detectar errores q no estamos gestionando
            showError = true //para que nos muestre el alert
            errorMessage = error.localizedDescription // pondrá el error del sist. no los creados por nosotros
            print(error)
        }
    }
    private func searchFilter(empleado: EmpModel) -> Bool {
        search.isEmpty || empleado.firstName.lowercased().contains(search.lowercased())
    }
}
