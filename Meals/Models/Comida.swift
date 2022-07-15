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
            return K.Tiempos.colMat
        case .desayuno:
            return K.Tiempos.desayuno
        case .colVesp:
            return K.Tiempos.colVesp
        case .comida:
            return K.Tiempos.comida
        case .colNoct:
            return K.Tiempos.colNoct
        case .cena:
            return K.Tiempos.cena
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
            return K.Ingredientes.Tipos.verdura
        case .fruta:
            return K.Ingredientes.Tipos.fruta
        case .cereal:
            return K.Ingredientes.Tipos.cereal
        case .leguminosa:
            return K.Ingredientes.Tipos.leguminosa
        case .animal:
            return K.Ingredientes.Tipos.animal
        case .leche:
            return K.Ingredientes.Tipos.leche
        case .grasa:
            return K.Ingredientes.Tipos.grasa
            
        }
        
    }
    
    static func firebaseFormat(_ unidad: Unidad) -> String {
        
        switch unidad {
            
        case .tz:
            return K.Ingredientes.Unidades.tz
        case .pza:
            return K.Ingredientes.Unidades.pza
        case .cdita:
            return K.Ingredientes.Unidades.cdita
        case .g:
            return K.Ingredientes.Unidades.g
            
        }
        
    }
    
    static func tipoFormat(_ tipo: String) -> Tipo {
        
        switch tipo {
            
        case K.Ingredientes.Tipos.verdura:
            return .verdura
        case K.Ingredientes.Tipos.fruta:
            return .fruta
        case K.Ingredientes.Tipos.cereal:
            return .cereal
        case K.Ingredientes.Tipos.leguminosa:
            return .leguminosa
        case K.Ingredientes.Tipos.animal:
            return .animal
        case K.Ingredientes.Tipos.leche:
            return .leche
        case K.Ingredientes.Tipos.grasa:
            return .grasa
        default:
            return .verdura
            
        }
        
    }
    
    static func unidadFormat(_ unidad: String) -> Unidad {
        
        switch unidad {
            
        case K.Ingredientes.Unidades.tz:
            return .tz
        case K.Ingredientes.Unidades.pza:
            return .pza
        case K.Ingredientes.Unidades.cdita:
            return .cdita
        case K.Ingredientes.Unidades.g:
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
