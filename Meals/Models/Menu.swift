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
    
    var porciones = [Tiempo.colMat : [Ingrediente.Tipo.fruta : 1,
                                      Ingrediente.Tipo.cereal : 1,
                                      Ingrediente.Tipo.leche : 1,
                                      Ingrediente.Tipo.grasa : 1],
                     
                     Tiempo.desayuno : [Ingrediente.Tipo.fruta : 1,
                                        Ingrediente.Tipo.cereal : 2,
                                        Ingrediente.Tipo.animal : 2,
                                        Ingrediente.Tipo.grasa : 1],
                     
                     Tiempo.colVesp : [Ingrediente.Tipo.verdura : 1],
                     
                     Tiempo.comida : [Ingrediente.Tipo.verdura : 1,
                                      Ingrediente.Tipo.cereal : 3,
                                      Ingrediente.Tipo.leguminosa : 1,
                                      Ingrediente.Tipo.animal : 2,
                                      Ingrediente.Tipo.grasa : 1],
                     
                     Tiempo.colNoct : [Ingrediente.Tipo.fruta : 1,
                                       Ingrediente.Tipo.cereal : 1],
                     
                     Tiempo.cena : [Ingrediente.Tipo.verdura : 1,
                                    Ingrediente.Tipo.cereal : 2,
                                    Ingrediente.Tipo.animal : 2,
                                    Ingrediente.Tipo.leche : 1,
                                    Ingrediente.Tipo.grasa : 1],
    ]
    
    // Singleton
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
    
    // Filtro para obtener el nombre y el tiempo de una comida buscada.
    func filterResults(_ text: String) -> [(String, String)] {
        
        var results = [(String, String)]()
        
        let comidasArray = [colacionesMat, desayunos, colacionesVesp, comidas, colacionesNoct, cenas]
        
        for array in comidasArray {
            
            for comida in array {
                
                if let _ = comida.nombre.range(of: text, options: .caseInsensitive) {
                    results.append((comida.nombre, comida.tiempo.description))
                }
                
            }
            
        }
        
        return results
        
    }
    
    func getPorciones(_ tiempo: Tiempo) -> [Ingrediente.Tipo : Int] {
        
        return porciones[tiempo]!
        
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
