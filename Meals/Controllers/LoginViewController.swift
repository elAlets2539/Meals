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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    User.id = Auth.auth().currentUser!.uid
//                    print(User.id)
                    self.performSegue(withIdentifier: "LoginSegue", sender: self)
                }
                
            }
            
        }
        
    }
    
}
