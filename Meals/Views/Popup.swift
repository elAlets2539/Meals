//
//  Popup.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 30/05/22.
//

import UIKit

protocol PopupDelegate {
    
    func ingredienteRegistrado(nombre: String, tipo: Ingrediente.Tipo, porcion: Int, unidad: Ingrediente.Unidad, cantidad: Int)
    
}

class Popup: UIView {
    
    var delegate: PopupDelegate?
    
    private let tipos = ["Verdura", "Fruta", "Cereal", "Leguminosa", "Animal", "Leche", "Grasa"]
    private var tipoSeleccionado: Ingrediente.Tipo = .verdura
    
    //MARK: - Nombre del ingrediente
    
    private let nombreTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nombre de ingrediente"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    //MARK: - Tipo del ingrediente
    
    private let tipoPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    //MARK: - Porciones
    
    private let porcionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Porción"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let unidadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Unidad", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        
        let taza = UIAction(title: "tz") { (action) in
            button.setTitle("tz", for: .normal)
        }
        let gramo = UIAction(title: "g") { (action) in
            button.setTitle("g", for: .normal)
        }
        let pieza = UIAction(title: "pza") { (action) in
            button.setTitle("pza", for: .normal)
        }
        let cucharadita = UIAction(title: "cdita") { (action) in
            button.setTitle("cdita", for: .normal)
        }
        let tipoMenu = UIMenu(title: "Unidad", options: .displayInline, children: [taza, gramo, pieza, cucharadita])
        button.menu = tipoMenu
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    private lazy var porcionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [porcionTextField, unidadButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        return stack
    }()
    
    //MARK: - Cantidades
    
    private let quitarIngredienteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.addTarget(self, action: #selector(quitarIngrediente), for: .touchUpInside)
        return button
    }()
    
    private let cantidadLabel: UILabel = {
       let label = UILabel()
        label.text = "1"
        label.tintColor = .black
        return label
    }()
    
    private let anadirIngredienteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(anadirIngrediente), for: .touchUpInside)
        return button
    }()
    
    private lazy var cantidadesStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [quitarIngredienteButton, cantidadLabel, anadirIngredienteButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        return stack
    }()
    
    //MARK: - Opciones
    
    private let agregarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Agregar", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(agregarPressed), for: .touchUpInside)
        return button
    }()
    
    private let cancelarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancelar", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
        return button
    }()
    
    private lazy var accionesStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cancelarButton, agregarButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nombreTextField, tipoPicker, porcionStack, cantidadesStack, accionesStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 24
        return v
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = .gray.withAlphaComponent(0.5)
        self.frame = UIScreen.main.bounds
        
        tipoPicker.dataSource = self
        tipoPicker.delegate = self
        
        self.addSubview(container)
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65).isActive = true
        
        container.addSubview(stack)
        
        //        stack.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        //        stack.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        stack.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.8).isActive = true
        stack.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        //        nombreTextField.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.9).isActive = true
        //        nombreTextField.centerXAnchor.constraint(equalTo: stack.centerXAnchor).isActive = true
        
        animateIn()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func quitarIngrediente() {
        
        let cantidad = Int(cantidadLabel.text!)!
        if cantidad > 1 {
            cantidadLabel.text = String(cantidad - 1)
        }
        
    }
    
    @objc private func anadirIngrediente() {
        
        let cantidad = Int(cantidadLabel.text!)!
        if cantidad <= 100 {
            cantidadLabel.text = String(cantidad + 1)
        }
        
    }
    
    @objc private func agregarPressed(_ sender: UIButton!) {
        
        let nombreIngrediente = nombreTextField.text!
        var unidad: Ingrediente.Unidad
        
        switch unidadButton.titleLabel!.text! {
            
        case "tz":
            unidad = .tz
            break
        case "pza":
            unidad = .pza
            break
        case "cdita":
            unidad = .cdita
            break
        case "g":
            unidad = .g
            break
        default:
            unidad = .tz
            break
            
        }
        
        if nombreIngrediente != "", let porcion = Int(porcionTextField.text!) {
            
            delegate?.ingredienteRegistrado(nombre: nombreTextField.text!, tipo: tipoSeleccionado, porcion: porcion, unidad: unidad, cantidad: Int(cantidadLabel.text!)!)
            self.animateOut()

        }
        
    }
    
    @objc private func animateIn() {
        
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.container.transform = .identity
            self.alpha = 1
        }
        
    }
    
    @objc private func animateOut() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        } completion: { complete in
            if complete {
                self.removeFromSuperview()
            }
        }

        
    }
    
}

extension Popup: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tipos[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch row {
            
        case 0:
            tipoSeleccionado = .verdura
            break
        case 1:
            tipoSeleccionado = .fruta
            break
        case 2:
            tipoSeleccionado = .cereal
            break
        case 3:
            tipoSeleccionado = .leguminosa
            break
        case 4:
            tipoSeleccionado = .animal
            break
        case 5:
            tipoSeleccionado = .leche
            break
        case 6:
            tipoSeleccionado = .grasa
            break
            
        default:
            break
        }
        
    }
    
}
