//
//  InicioViewController.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 27/05/22.
//

import UIKit

class InicioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor(named: "Elements")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let dataManager = DataManager()
        dataManager.getComidasFromDB()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    @IBAction func registrarComidaPressed(_ sender: UIButton) {
        
        print("Oi")
        
    }
    
    @IBAction func agregarComidaPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "AgregarComidaSegue", sender: self)
        
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
