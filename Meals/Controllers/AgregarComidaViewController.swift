//
//  RegistrarComidaViewController.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 27/05/22.
//

import UIKit
import Firebase

class AgregarComidaViewController: UIViewController, PopupDelegate {
    
    let tiemposTitles = ["Colación matutina",
                         "Desayuno",
                         "Colación vespertina",
                         "Comida",
                         "Colación nocturna",
                         "Cena"]
    var tiempoSeleccionado = "Colación matutina"
//    var ingredientes = [Ingrediente]()
    var receta = Receta()
    
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var tiempoPicker: UIPickerView!
    @IBOutlet weak var ingredientesTableView: UITableView!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tiempoPicker.delegate = self
        tiempoPicker.dataSource = self
        
        ingredientesTableView.delegate = self
        ingredientesTableView.dataSource = self
        
        setupElements()
        
    }
    
    func setupElements() {
        
        ingredientesTableView.layer.cornerRadius = 20
        ingredientesTableView.backgroundColor = UIColor(named: "Element Bg Sand")
        
        nombreTextField.backgroundColor = UIColor(named: "Element Bg Sand")
        
    }
    
    @IBAction func addIngredientePressed(_ sender: UIButton) {
        
        let pop = Popup()
        pop.delegate = self
        view.addSubview(pop)
        pop.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pop.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pop.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pop.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    @IBAction func guardarPressed(_ sender: UIButton) {
        
        let nombre = nombreTextField.text!
        
        if nombre != "" {
            
            var ingredientes = [[String: Any]]()
            for insumo in receta.insumos {
                ingredientes.append(receta.formatInsumoToDict(insumo.key))
            }

            db.collection("users").document("\(User.id)").collection("menu").addDocument(data: ["nombre": nombre,
                                                     "tiempo": tiempoSeleccionado,
                                                     "ingredientes": ingredientes]) { error in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Succesfully saved data.")
                    self.dismiss(animated: true)
                }
            }

        }
        
    }
    
    @IBAction func cancelarPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func ingredienteRegistrado(nombre: String, tipo: Ingrediente.Tipo, porcion: Int, unidad: Ingrediente.Unidad, cantidad: Int) {
        let ingrediente = Ingrediente(nombre, tipo, porcion, unidad)
//        ingredientes.append(ingrediente)
        receta.insumos[ingrediente] = cantidad
        self.ingredientesTableView.reloadData()
    }
    
}

//MARK: - UIElements delegates and data sources

extension AgregarComidaViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tiemposTitles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tiempoSeleccionado = tiemposTitles[row]
    }
    
}

extension AgregarComidaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return ingredientes.count
        return receta.insumos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let keysArray = Array(receta.insumos.keys)
        
        let cell = ingredientesTableView.dequeueReusableCell(withIdentifier: "IngredienteCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
//        content.text = ingredientes[indexPath.row].nombre
        content.text = keysArray[indexPath.row].nombre
        cell.contentConfiguration = content
        
        return cell
        
    }
    
}
