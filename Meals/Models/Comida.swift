//
//  Comida.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 27/05/22.
//

import Foundation

enum Tiempo {
    
    case colMat
    case desayuno
    case colVesp
    case comida
    case colNoct
    case cena
    
    var description : String {
        
        switch self {
        case .colMat:
            return "Colación matutina"
        case .desayuno:
            return "Desayuno"
        case .colVesp:
            return "Colación vespertina"
        case .comida:
            return "Comida"
        case .colNoct:
            return "Colación nocturna"
        case .cena:
            return "Cena"
        }
        
    }
    
}

struct Ingrediente: Hashable {
    
    enum Tipo {
        case verdura
        case fruta
        case cereal
        case leguminosa
        case animal
        case leche
        case grasa
    }
    
    enum Unidad {
        case tz
        case pza
        case cdita
        case g
    }
    
    let nombre: String
    let tipo: Tipo
    let porcion: Int
    let unidad: Unidad
    
    init(_ nombre: String, _ tipo: Tipo, _ porcion: Int, _ unidad: Unidad) {
        self.nombre = nombre
        self.tipo = tipo
        self.porcion = porcion
        self.unidad = unidad
    }
    
    static func firebaseFormat(_ tipo: Tipo) -> String {
        
        switch tipo {
            
        case .verdura:
            return "verdura"
        case .fruta:
            return "fruta"
        case .cereal:
            return "cereal"
        case .leguminosa:
            return "leguminosa"
        case .animal:
            return "animal"
        case .leche:
            return "leche"
        case .grasa:
            return "grasa"
            
        }
        
    }
    
    static func firebaseFormat(_ unidad: Unidad) -> String {
        
        switch unidad {
            
        case .tz:
            return "tz"
        case .pza:
            return "pza"
        case .cdita:
            return "cdita"
        case .g:
            return "g"
            
        }
        
    }
    
    static func tipoFormat(_ tipo: String) -> Tipo {
        
        switch tipo {
            
        case "verdura":
            return .verdura
        case "fruta":
            return .fruta
        case "cereal":
            return .cereal
        case "leguminosa":
            return .leguminosa
        case "animal":
            return .animal
        case "leche":
            return .leche
        case "grasa":
            return .grasa
        default:
            return .verdura
            
        }
        
    }
    
    static func unidadFormat(_ unidad: String) -> Unidad {
        
        switch unidad {
            
        case "tz":
            return .tz
        case "pza":
            return .pza
        case "cdita":
            return .cdita
        case "g":
            return .g
        default:
            return .tz
            
        }
        
    }
    
}

struct Receta {
    
    var insumos: [Ingrediente : Int]
    
    init() {
        insumos = [Ingrediente : Int]()
    }
    
    func formatInsumoToDict(_ ingrediente: Ingrediente) -> [String : Any] {
        
        var dict = [String : Any]()
//        let keys = Array(insumos.keys)
        
//        for key in keys {
            
//            if key.nombre == nombre {
                
                dict["nombre"] = ingrediente.nombre
                dict["tipo"] = Ingrediente.firebaseFormat(ingrediente.tipo)
                dict["porcion"] = ingrediente.porcion
                dict["unidad"] = Ingrediente.firebaseFormat(ingrediente.unidad)
                dict["cantidad"] = insumos[ingrediente]
                
//            }
            
//        }
        
        return dict
        
    }
    
    static func formatDictToInsumo(_ dict: [String : Any]) -> (Ingrediente, Int) {
        
        let nombre = dict["nombre"] as! String
        let tipoStr = dict["tipo"] as! String
        let porcion = dict["porcion"] as! Int
        let unidadStr = dict["unidad"] as! String
        
        let tipo = Ingrediente.tipoFormat(tipoStr)
        let unidad = Ingrediente.unidadFormat(unidadStr)
        
        let ingrediente = Ingrediente(nombre, tipo, porcion, unidad)
        let insumo = (ingrediente, (dict["cantidad"] as! Int))
        
        return insumo
        
    }
    
//    public mutating func agregarIngrediente(_ ingrediente: Ingrediente, _ cantidad: Int) {
//        insumos[ingrediente] = cantidad
//    }
    
//    public func obtenerIngredientes() -> [Ingrediente : Int] {
//        return insumos
//    }
    
}

struct Comida {
    
    let nombre: String
    let receta: Receta
    let tiempo: Tiempo
    
    init(_ nombre: String, _ receta: Receta, _ tiempo: Tiempo) {
        self.nombre = nombre
        self.receta = receta
        self.tiempo = tiempo
    }
    
}
