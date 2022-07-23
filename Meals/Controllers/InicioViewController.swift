//
//  InicioViewController.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 27/05/22.
//

import UIKit

class InicioViewController: UIViewController {

    @IBOutlet weak var comidaPendienteLabel: UILabel!
    
    @IBOutlet weak var grupo1Label: UILabel!
    @IBOutlet weak var grupo2Label: UILabel!
    @IBOutlet weak var grupo3Label: UILabel!
    @IBOutlet weak var grupo4Label: UILabel!
    @IBOutlet weak var grupo5Label: UILabel!
    @IBOutlet weak var grupo6Label: UILabel!
    @IBOutlet weak var grupo7Label: UILabel!
    
    @IBOutlet weak var registrarView: UIView!
    @IBOutlet weak var sugerenciaView: UIView!
    @IBOutlet weak var agregarView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    let menu = Menu.menu
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor(named: "Elements")
        
        setupViews()
        
    }
    
    // Obtener la siguiente comida pendiente y obtener todas las comidas del menú de firebase.
    override func viewWillAppear(_ animated: Bool) {
        
        let dataManager = DataManager()
        
        dataManager.getDiarioFromDB() { [self] in
            
            self.comidaPendienteLabel.text = "Siguiente comida: \(User.comidaPendiente)"
//            setPorciones(User.comidaPendiente)
            setPorciones()
            
        }
        
        dataManager.getComidasFromDB()
        
    }
    
    // Agregar botón de navegación para regresar a esta pantalla.
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Atrás", style: .plain, target: nil, action: nil)
    }
    
    func setupViews() {
        
        registrarView.layer.cornerRadius = 20
        sugerenciaView.layer.cornerRadius = 20
        agregarView.layer.cornerRadius = 20
        menuView.layer.cornerRadius = 20
        
    }
    
    // Preparar labels de acuerdo con las porciones a consumir.
//    func setPorciones(_ comida: String) {
    func setPorciones() {
        
//        if comida != "Ninguna" {
        if User.siguienteComida() != "Ninguna" {
         
            // Contar las diferentes porciones para elegir en cuáles labels colocarlas (para estar centradas)
//            let porciones = menu.getPorciones(User.comidaPendiente)
            let porciones = User.porcionesPendientes
            let grupos = [grupo1Label, grupo2Label, grupo3Label, grupo4Label, grupo5Label, grupo6Label, grupo7Label]
            var index = 0
            
            switch porciones.count {
            case 1, 2:
                index = 2
            case 3, 4:
                index = 1
            default:
                index = 0
            }
            
            // Limpiar labels
            for grupo in grupos {
                grupo?.text = ""
            }
            
            // Preparar texto de cada label
            for porcion in porciones {
                
                var emoji = ""
                
                switch porcion.key.description {
                case K.Ingredientes.Tipos.verdura: emoji = "🥦"
                case K.Ingredientes.Tipos.fruta: emoji = "🍎"
                case K.Ingredientes.Tipos.cereal: emoji = "🍞"
                case K.Ingredientes.Tipos.leguminosa: emoji = "🫘"
                case K.Ingredientes.Tipos.animal: emoji = "🥩"
                case K.Ingredientes.Tipos.leche: emoji = "🥛"
                case K.Ingredientes.Tipos.grasa: emoji = "🥜"
                default: emoji = "🌶"
                }
                
                let p = porcion.value == 1 ? "porción" : "porciones"
                
                grupos[index]?.text = "\(emoji) \(porcion.value) \(p) de \(porcion.key)"
                index += 1
                
            }
            
        } else {
            
            grupo3Label.text = "😋👌"
            
        }
        
    }
    
    // Ir a pantalla de Registrar comida.
    @IBAction func registrarComidaPressed(_ sender: UIButton) {
        
        let registrarComdiaVC = RegistrarComidaViewController()
        registrarComdiaVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(registrarComdiaVC, animated: true)
        
    }
    
    // Ir a pantalla de Agregar comida.
    @IBAction func agregarComidaPressed(_ sender: UIButton) {
        
        let agregarComidaVC = self.storyboard?.instantiateViewController(withIdentifier: "AgregarComidaVC") as! AgregarComidaViewController
        agregarComidaVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(agregarComidaVC, animated: true, completion: nil)
        
    }
    
    // Ir a pantalla del menú.
    @IBAction func verMenuPressed(_ sender: UIButton) {
        
        let menuTableViewController = MenuTableViewController()
        menuTableViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(menuTableViewController, animated: true)
        
    }

}
