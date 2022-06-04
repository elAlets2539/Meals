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
        textField.backgroundColor = UIColor(named: "Element Bg Light Green")
        return textField
    }()
    
    private lazy var nombreView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nombreTextField)
        nombreTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nombreTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nombreTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        return view
    }()
    
    //MARK: - Tipo del ingrediente
    
    private let tipoPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tintColor = UIColor(named: "Text")
        return picker
    }()
    
    //MARK: - Porciones
    
    let porcionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Porción"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(named: "Element Bg Light Green")
        return textField
    }()
    
    private lazy var porcionTextFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(porcionTextField)
        porcionTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        porcionTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        porcionTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        return view
    }()
    
    private let unidadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Unidad", for: .normal)
        button.setTitleColor(UIColor(named: "Text"), for: .normal)
        
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
    
    private lazy var unidadView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(unidadButton)
        unidadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        unidadButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        unidadButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        return view
    }()
    
    private lazy var porcionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [porcionTextFieldView, unidadView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        stack.alignment = .center
        porcionTextFieldView.topAnchor.constraint(equalTo: stack.topAnchor).isActive = true
        porcionTextFieldView.bottomAnchor.constraint(equalTo: stack.bottomAnchor).isActive = true
        porcionTextFieldView.leadingAnchor.constraint(equalTo: stack.leadingAnchor).isActive = true
        unidadView.topAnchor.constraint(equalTo: stack.topAnchor).isActive = true
        unidadView.leadingAnchor.constraint(equalTo: porcionTextFieldView.trailingAnchor).isActive = true
        unidadView.bottomAnchor.constraint(equalTo: stack.bottomAnchor).isActive = true
        return stack
    }()
    
    //MARK: - Cantidades
    
    private var quitarIngredienteButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let quitarIngredienteButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "minus"), for: .normal)
            button.tintColor = UIColor(named: "Elements")
            button.addTarget(self, action: #selector(quitarIngrediente), for: .touchUpInside)
            return button
        }()
        view.addSubview(quitarIngredienteButton)
        quitarIngredienteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        quitarIngredienteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    private let cantidadLabel: UILabel = {
       let label = UILabel()
        label.text = "1"
        label.tintColor = UIColor(named: "Text")
        return label
    }()
    
    private var anadirIngredienteButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let anadirIngredienteButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "plus"), for: .normal)
            button.tintColor = UIColor(named: "Elements")
            button.addTarget(self, action: #selector(anadirIngrediente), for: .touchUpInside)
            return button
        }()
        view.addSubview(anadirIngredienteButton)
        anadirIngredienteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        anadirIngredienteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    private lazy var cantidadesStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [quitarIngredienteButtonView, cantidadLabel, anadirIngredienteButtonView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        cantidadLabel.centerXAnchor.constraint(equalTo: stack.centerXAnchor).isActive = true
        cantidadLabel.topAnchor.constraint(equalTo: stack.topAnchor).isActive = true
        cantidadLabel.bottomAnchor.constraint(equalTo: stack.bottomAnchor).isActive = true
        quitarIngredienteButtonView.topAnchor.constraint(equalTo: stack.topAnchor).isActive = true
        quitarIngredienteButtonView.bottomAnchor.constraint(equalTo: stack.bottomAnchor).isActive = true
        quitarIngredienteButtonView.leadingAnchor.constraint(equalTo: stack.leadingAnchor).isActive = true
        quitarIngredienteButtonView.trailingAnchor.constraint(equalTo: cantidadLabel.leadingAnchor).isActive = true
        anadirIngredienteButtonView.topAnchor.constraint(equalTo: stack.topAnchor).isActive = true
        anadirIngredienteButtonView.bottomAnchor.constraint(equalTo: stack.bottomAnchor).isActive = true
        anadirIngredienteButtonView.leadingAnchor.constraint(equalTo: cantidadLabel.trailingAnchor).isActive = true
        anadirIngredienteButtonView.trailingAnchor.constraint(equalTo: stack.trailingAnchor).isActive = true
        return stack
    }()
    
    //MARK: - Opciones
    
    private let agregarButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Inicio Buttons")
//        button.setBackgroundImage(UIImage(color: UIColor(named: "Inicio Buttons")!), for: .normal)
        button.setTitle("Agregar", for: .normal)
        button.setTitleColor(UIColor(named: "Elements"), for: .normal)
        button.addTarget(self, action: #selector(agregarPressed), for: .touchUpInside)
        return button
    }()
    
    private let cancelarButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Inicio Buttons")
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
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(named: "Inicio Buttons")
        v.layer.cornerRadius = 24
        return v
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = .gray.withAlphaComponent(0.5)
        self.frame = UIScreen.main.bounds
        
        tipoPicker.dataSource = self
        tipoPicker.delegate = self
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(container)
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65).isActive = true
        
        container.addSubview(nombreView)
        nombreView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2).isActive = true
        nombreView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        nombreView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        nombreView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        
        container.addSubview(tipoPicker)
        tipoPicker.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.3).isActive = true
        tipoPicker.topAnchor.constraint(equalTo: nombreView.bottomAnchor).isActive = true
        tipoPicker.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        tipoPicker.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        
        container.addSubview(porcionStack)
        porcionStack.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2).isActive = true
        porcionStack.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
        porcionStack.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        porcionStack.topAnchor.constraint(equalTo: tipoPicker.bottomAnchor).isActive = true
        
        container.addSubview(cantidadesStack)
        cantidadesStack.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2).isActive = true
        cantidadesStack.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
        cantidadesStack.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        cantidadesStack.topAnchor.constraint(equalTo: porcionStack.bottomAnchor).isActive = true
        
        container.addSubview(accionesStack)
        accionesStack.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.1).isActive = true
        accionesStack.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
        accionesStack.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        accionesStack.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
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

//public extension UIImage {
//
//    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
//
//        let rect = CGRect(origin: .zero, size: size)
//        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
//        color.setFill()
//        UIRectFill(rect)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        guard let cgImage = image?.cgImage else { return nil }
//        self.init(cgImage: cgImage)
//
//    }
//
//}
