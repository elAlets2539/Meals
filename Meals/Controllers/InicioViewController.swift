//
//  InicioViewController.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 27/05/22.
//

import UIKit

class InicioViewController: UIViewController {

    @IBOutlet weak var comidaPendienteLabel: UILabel!
    @IBOutlet weak var registrarView: UIView!
    @IBOutlet weak var sugerenciaView: UIView!
    @IBOutlet weak var agregarView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor(named: "Elements")
        
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let dataManager = DataManager()
        dataManager.getDiarioFromDB(comidaPendienteLabel)
        dataManager.getComidasFromDB()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Atrás", style: .plain, target: nil, action: nil)
    }
    
    func setupViews() {
        
        registrarView.layer.cornerRadius = 20
        sugerenciaView.layer.cornerRadius = 20
        agregarView.layer.cornerRadius = 20
        menuView.layer.cornerRadius = 20
        
    }
    
    @IBAction func registrarComidaPressed(_ sender: UIButton) {
        
        let registrarComdiaVC = RegistrarComidaViewController()
        registrarComdiaVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(registrarComdiaVC, animated: true)
        
    }
    
    @IBAction func agregarComidaPressed(_ sender: UIButton) {
        
//        self.performSegue(withIdentifier: "AgregarComidaSegue", sender: self)
        let agregarComidaVC = self.storyboard?.instantiateViewController(withIdentifier: "AgregarComidaVC") as! AgregarComidaViewController
        agregarComidaVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(agregarComidaVC, animated: true, completion: nil)
        
    }
    
    @IBAction func verMenuPressed(_ sender: UIButton) {
        
        let menuTableViewController = MenuTableViewController()
        menuTableViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(menuTableViewController, animated: true)
        //self.present(menuTableViewController, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
