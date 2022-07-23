//
//  RegistrarComidaViewController.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 27/05/22.
//

import UIKit

class AgregarComidaViewController: UIViewController, PopupDelegate {
    
    @IBOutlet weak var cancelarButton: UIButton!
    @IBOutlet weak var guardarButton: UIButton!
    
    // Títulos del pickerView.
    let tiemposTitles = [K.Tiempos.colMat,
                         K.Tiempos.desayuno,
                         K.Tiempos.colVesp,
                         K.Tiempos.comida,
                         K.Tiempos.colNoct,
                         K.Tiempos.cena]
    
    // Opción predeterminada de tiempo es la colación matutina.
    var tiempoSeleccionado = K.Tiempos.colMat

    var receta = Receta()
    let dataManager = DataManager()
    
    // Determinar si se va a agregar una nueva comida al menú (opción por defecto) o únicamente registrarla como comida del día.
    enum Modo {
        case agregar
        case registrar
    }
    
    var modo: Modo = .agregar
    
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var tiempoPicker: UIPickerView!
    @IBOutlet weak var ingredientesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tiempoPicker.delegate = self
        tiempoPicker.dataSource = self
        
        ingredientesTableView.delegate = self
        ingredientesTableView.dataSource = self
        
        setupElements()
        
    }
    
    // Redondear esquinas de elementos y establecer colores.
    func setupElements() {
        
        ingredientesTableView.layer.cornerRadius = 20
        ingredientesTableView.backgroundColor = UIColor(named: "Element Bg Sand")
        
        nombreTextField.backgroundColor = UIColor(named: "Element Bg Sand")
        
        cancelarButton.layer.cornerRadius = 20
        guardarButton.layer.cornerRadius = 20
        
    }
    
    // Abrir el Popup para agregar nuevo ingrediente a la receta.
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
            
            switch modo {
                
            case .agregar:
                
                agregarComida(nombre)
                
                self.dismiss(animated: true)
                
                break
                
            case .registrar:
                
                dataManager.registrarComida(nombre)
                alertAgregarAlMenu(nombre)
                
//                self.dismiss(animated: true)
                
                break
            
            }

        }
        
    }
    
    // Agregar comida a Firebase.
    func agregarComida(_ nombre: String) {
        
        var ingredientes = [[String: Any]]()
        for insumo in receta.insumos {
            ingredientes.append(receta.formatInsumoToDict(insumo.key))
        }

        dataManager.agregarComida(nombre, tiempoSeleccionado, ingredientes)
        
    }
    
    // Alerta para preguntar si se desea también agregar la comida registrada al menú.
    func alertAgregarAlMenu(_ nombre: String) {
        
        let alert = UIAlertController(title: "¿Agregar \(nombre) al menú?", message: "", preferredStyle: .alert)
        
        let aceptar = UIAlertAction(title: "Aceptar", style: .default) { action in
            self.agregarComida(nombre)
            self.dismiss(animated: true)
        }
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .default) { action in
            self.dismiss(animated: true)
        }

        alert.addAction(cancelar)
        alert.addAction(aceptar)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelarPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    // Función que llama el Popup delegate.
    func ingredienteRegistrado(nombre: String, tipo: Ingrediente.Tipo, porcion: Int, unidad: Ingrediente.Unidad, cantidad: Int) {
        let ingrediente = Ingrediente(nombre, tipo, porcion, unidad)
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
        return receta.insumos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let keysArray = Array(receta.insumos.keys)
        
        let cell = ingredientesTableView.dequeueReusableCell(withIdentifier: "IngredienteCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = keysArray[indexPath.row].nombre
        cell.contentConfiguration = content
        
        return cell
        
    }
    
}
