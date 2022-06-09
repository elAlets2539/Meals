//
//  User.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 31/05/22.
//

import Foundation

struct User {
 
    static var id: String = ""
    static var comidaPendiente = "Colación matutina"
    static var siguienteComida: String = {
        
        switch comidaPendiente {
            
        case "Colación matutina":
            return "Desayuno"
        case "Desayuno":
            return "Colación vespertina"
        case "Colación vespertina":
            return "Comida"
        case "Comida":
            return "Colación nocturna"
        case "Colación nocturna":
            return "Cena"
        case "Cena":
            return "Ninguna"
        default:
            return "Colación matutina"
            
        }
        
    }()
    
}
