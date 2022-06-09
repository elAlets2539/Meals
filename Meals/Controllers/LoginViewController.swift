//
//  ViewController.swift
//  Meals
//
//  Created by Alejandro Sosa Carrillo on 27/05/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.backgroundColor = UIColor(named: "Element Bg Sand")
        passwordTextField.backgroundColor = UIColor(named: "Element Bg Sand")
        loginButton.layer.cornerRadius = 20
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    User.id = Auth.auth().currentUser!.uid
//                    print(User.id)
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Salir", style: .plain, target: nil, action: nil)
                    let inicioVC = self.storyboard?.instantiateViewController(withIdentifier: "InicioVC") as! InicioViewController
                    self.navigationController?.pushViewController(inicioVC, animated: true)
                }
                
            }
            
        }
        
    }
    
}

