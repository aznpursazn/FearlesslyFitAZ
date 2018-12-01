//
//  SignUpViewController.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 10/29/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    let picker = UIImagePickerController()
    var selImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        userImage.layer.cornerRadius = 45
        userImage.clipsToBounds = true
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectProfileView))
        userImage.addGestureRecognizer(tapGuesture)
        userImage.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismiss_onclick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func signUpAction(_ sender: Any) {
        guard let userText = usernameTextField.text, !userText.isEmpty else {
            let alertError = UIAlertController(title: "Username Input Error", message: "Correct data input is required.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
            return
        }
        
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
        
        // let default image be a place-holder
        if self.selImage == nil {
            
            let alertError = UIAlertController(title: "Image Error", message: "Please upload an image through photo library.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
            //self.selImage = UIImage(named: "person-placeholder")
        } else  {
            guard let userImg = self.selImage, let imageData = userImg.jpegData(compressionQuality: 0.1) else {
                return
            }
            
            AuthService.signUp(u: userText, e: email, p: pass, i: imageData, onSuccess: {
                self.performSegue(withIdentifier: "signUptoTabbarVC", sender: nil)
            }, onError: { error in
                let alert = UIAlertController(title: "Input Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            })
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @objc func handleSelectProfileView() {
        present(picker, animated: true, completion: nil)
    }
    
    // textfield func for the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.usernameTextField.resignFirstResponder()
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

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        selImage = selectedImage
        userImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
