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
    
    func getDiarioFromDB(_ label: UILabel) {
        
        db.collection("users").document(User.id).collection("diario").getDocuments { snapshot, error in
            
            if error != nil {
                print("Sepa la bola qué pasó, \(error!)")
            } else {
                
                if let snap = snapshot {
                    
                    let documents = snap.documents
                    
                    if !documents.isEmpty {
                        let data = documents[0].data()
                        User.comidaPendiente = data["comidaPendiente"] as! String
                    }
                    
                    DispatchQueue.main.async {
                        label.text = User.comidaPendiente
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func agregarComida(_ nombre: String, _ tiempo: String, _ ingredientes: [[String: Any]]) {
        
        db.collection("users").document(User.id).collection("menu").addDocument(data: ["nombre": nombre,
                                                 "tiempo": tiempo,
                                                 "ingredientes": ingredientes]) { error in
            
            self.catchError(error)
            
        }
        
    }
    
    func registrarComida() {
        
        let date = getDate()
        var documentID = ""
        
        db.collection("users").document(User.id).collection("diario").getDocuments { snapshot, error in

            if error != nil {
                print("Sepa la bola qué pasó, \(error!)")
            } else {

                if let snap = snapshot, !snap.documents.isEmpty {
                    
                    documentID = snap.documents.first!.documentID

                }
                
                if documentID != "" {
                    
                    db.collection("users").document(User.id).collection("diario").document(documentID).updateData(["dia" : date,
                                                                                                                   "comidaPendiente" : User.siguienteComida])
                    
                } else {
                 
                    db.collection("users").document(User.id).collection("diario").addDocument(data: ["dia" : date,
                                                                                                     "comidaPendiente" : User.siguienteComida]) { error in
                        
                        self.catchError(error)
                        
                    }
                    
                }

            }

        }
        
    }
    
    private func getDate() -> String {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
        
    }
    
    private func catchError(_ error: Error?) {
        
        if let e = error {
            print("There was an issue saving data to firestore, \(e)")
        } else {
            print("Succesfully saved data.")
        }
        
    }
    
}
