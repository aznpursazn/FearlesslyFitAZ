//
//  LoginViewController.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 10/29/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signinAction(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else {
            let alertError = UIAlertController(title: "Email Input Error", message: "Correct data input is required.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
            return
        }
        
        guard let pass = passwordTextField.text, !pass.isEmpty else {
            let alertError = UIAlertController(title: "Password Input Error", message: "Correct data input is required.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
            return
        }
        
        AuthService.login(e: email, p: pass, onSuccess: {
            self.performSegue(withIdentifier: "signIntoTabbarVC", sender: nil)
        }, onError: { error in
            let alert = UIAlertController(title: "Input Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        })
        
    }
    
    // textfield func for the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return true;
    }
    
    // disappear keyboard when tap somehere else in the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

}
