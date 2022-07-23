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
    
    private lazy var comidasArray = [colacionesMat, desayunos, colacionesVesp, comidas, colacionesNoct, cenas]
    
    // Hardcoded, cambiar posteriormente a plan ingresado por el usuario.
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
        
        for array in comidasArray {
            
            for comida in array {
                
                if let _ = comida.nombre.range(of: text, options: .caseInsensitive) {
                    results.append((comida.nombre, comida.tiempo.description))
                }
                
            }
            
        }
        
        return results
        
    }
    
    // Proporcionar un objeto Comida de un nombre dado.
    func getComida(nombre: String) -> Comida? {
        
        for array in comidasArray {
            
            for comida in array {
                
                if let _ = comida.nombre.range(of: nombre, options: .caseInsensitive) {
                    return comida
                }
                
            }
            
        }
        
        return nil
        
    }
    
    // Proporcionar las porciones de un tiempo dado.
    func getPorciones(_ tiempo: String) -> [Ingrediente.Tipo : Int] {
        
        switch tiempo {
            
        case K.Tiempos.colMat: return porciones[Tiempo.colMat]!
        case K.Tiempos.desayuno: return porciones[Tiempo.desayuno]!
        case K.Tiempos.colVesp: return porciones[Tiempo.colVesp]!
        case K.Tiempos.comida: return porciones[Tiempo.comida]!
        case K.Tiempos.colNoct: return porciones[Tiempo.colNoct]!
        case K.Tiempos.cena: return porciones[Tiempo.cena]!
        default: return porciones[Tiempo.colMat]!
            
        }
        
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
