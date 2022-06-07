//
//  Menu.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 27/05/22.
//

import Foundation

class Menu {
    
    var colacionesMat = [Comida]()
    var desayunos = [Comida]()
    var colacionesVesp = [Comida]()
    var comidas = [Comida]()
    var colacionesNoct = [Comida]()
    var cenas = [Comida]()
    
    static let menu = Menu()
    
    init () {
        
    }
    
    func agregarComida(tiempo: Tiempo, nombre: String, receta: Receta) {
        
        let comida = Comida(nombre, receta, tiempo)
        
        switch tiempo {
        case .colMat:
            colacionesMat.append(comida)
        case .desayuno:
            desayunos.append(comida)
        case .colVesp:
            colacionesVesp.append(comida)
        case .comida:
            comidas.append(comida)
        case .colNoct:
            colacionesNoct.append(comida)
        case .cena:
            cenas.append(comida)
        }
        
    }
    
    func resetMenu() {
        
        colacionesMat = []
        desayunos = []
        colacionesVesp = []
        comidas = []
        colacionesNoct = []
        cenas = []
        
    }
    
    func filterResults(_ text: String) -> [String] {
        
        var results = [String]()
        
        let comidasArray = [colacionesMat, desayunos, colacionesVesp, comidas, colacionesNoct, cenas]
        
        for array in comidasArray {
            
            for comida in array {
                
//                if comida.nombre.contains(text) {
                if let _ = comida.nombre.range(of: text, options: .caseInsensitive) {
                    results.append(comida.nombre)
                }
                
            }
            
        }
        
        return results
        
    }
    
//    public func sugerencia(tiempo: Tiempo) -> Comida {
//
//        var sugerencia: Comida
//        var receta = Receta()
//
//        var ingrediente = Ingrediente("Tortilla", .cereal, 1, .pza)
//        receta.agregarIngrediente(ingrediente, 2)
//        ingrediente = Ingrediente("Gerber", .verdura, 1, .tz)
//        receta.agregarIngrediente(ingrediente, 1)
//
//        sugerencia = Comida("Tacos de Gerber", receta, .cena)
//
//        print(sugerencia.nombre)
//        return sugerencia
//
//    }
    
}
