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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor(named: "Elements")
        
        setupViews()
        
    }
    
    // Obtener la siguiente comida pendiente y obtener todas las comidas del menú de firebase.
    override func viewWillAppear(_ animated: Bool) {
        let dataManager = DataManager()
        dataManager.getDiarioFromDB(comidaPendienteLabel)
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
    
    // Ir a pantalla de Registrar comida.
    @IBAction func registrarComidaPressed(_ sender: UIButton) {
        
        let registrarComdiaVC = RegistrarComidaViewController()
        registrarComdiaVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(registrarComdiaVC, animated: true)
        
    }
    
    // Ir a pantalla de Agregar comida.
    @IBAction func agregarComidaPressed(_ sender: UIButton) {
        
//        self.performSegue(withIdentifier: "AgregarComidaSegue", sender: self)
        let agregarComidaVC = self.storyboard?.instantiateViewController(withIdentifier: "AgregarComidaVC") as! AgregarComidaViewController
        agregarComidaVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(agregarComidaVC, animated: true, completion: nil)
        
    }
    
    // Ir a pantalla del menú.
    @IBAction func verMenuPressed(_ sender: UIButton) {
        
        let menuTableViewController = MenuTableViewController()
        menuTableViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(menuTableViewController, animated: true)
        //self.present(menuTableViewController, animated: true)
        
    }

}
