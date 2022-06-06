//
//  DataManager.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 03/06/22.
//

import Foundation
import Firebase

struct DataManager {
    
    let db = Firestore.firestore()
    let menu = Menu.menu

    init() {
        
    }
    
    func getComidasFromDB() {
        
        menu.resetMenu()
        
        db.collection("users").document(User.id).collection("menu").getDocuments { snapshot, error in
            
            if error != nil {
                print("Sepa la bola qué pasó, \(error!)")
            } else {
                
                if let snap = snapshot {
                    
                    for comida in snap.documents {
                        
                        let data = comida.data()
                        
                        let nombre = data["nombre"] as! String
                        let tiempoString = data["tiempo"] as! String
                        var tiempo: Tiempo
                        var receta = Receta()
                        let ingredientesArray = data["ingredientes"] as! [Any]
                        
                        switch tiempoString {
                            
                        case "Colación matutina":
                            tiempo = Tiempo.colMat
                            break
                        case "Desayuno":
                            tiempo = Tiempo.desayuno
                            break
                        case "Colación vespertina":
                            tiempo = Tiempo.colVesp
                            break
                        case "Comida":
                            tiempo = Tiempo.comida
                            break
                        case "Colación nocturna":
                            tiempo = Tiempo.colNoct
                            break
                        case "Cena":
                            tiempo = Tiempo.cena
                            break
                        default:
                            tiempo = Tiempo.colMat
                            
                        }
                        
                        for ingrediente in ingredientesArray {
                            
                            let insumo = Receta.formatDictToInsumo(ingrediente as! [String: Any])
                            receta.insumos[insumo.0] = insumo.1
                            
                        }
                        
                        self.menu.agregarComida(tiempo: tiempo, nombre: nombre, receta: receta)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
