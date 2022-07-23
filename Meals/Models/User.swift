//
//  User.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 31/05/22.
//

import Foundation

struct User {
 
    static var id: String = ""
    static var comidaPendiente = K.Tiempos.colMat
    static var lastUpdateDate = ""
    
    static var porcionesPendientes = [Ingrediente.Tipo : Int]()
    static var porcionesExtras = [Ingrediente.Tipo : Int]()
    
    static func siguienteComida() -> String {
        
        switch comidaPendiente {
            
        case K.Tiempos.colMat:
            return K.Tiempos.desayuno
        case K.Tiempos.desayuno:
            return K.Tiempos.colVesp
        case K.Tiempos.colVesp:
            return K.Tiempos.comida
        case K.Tiempos.comida:
            return K.Tiempos.colNoct
        case K.Tiempos.colNoct:
            return K.Tiempos.cena
        case K.Tiempos.cena:
            return "Ninguna"
        default:
            return K.Tiempos.colMat
            
        }
        
    }
    
}
