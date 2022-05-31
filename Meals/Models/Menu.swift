//
//  Menu.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 27/05/22.
//

import Foundation

class Menu {
    
    private var colacionesMat = [Comida]()
    private var desayunos = [Comida]()
    private var colacionesVesp = [Comida]()
    private var comidas = [Comida]()
    private var colacionesNoct = [Comida]()
    private var cenas = [Comida]()
    
    init () {
        
    }
    
    public func agregarComida(tiempo: Tiempo, nombre: String, receta: Receta) {
        
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
