//
//  AddRecipeViewController.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 11/27/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class AddRecipeViewController: UIViewController {
    
    var recipesInfo:recipes = recipes()
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ingredientsTextField: UITextView!
    @IBOutlet weak var instructionsTextField: UITextView!
    
    var selImage: UIImage?
    
    let picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(AddRecipeViewController.handleSelectProfileView))
        foodImage.addGestureRecognizer(tapGuesture)
        foodImage.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @objc func handleSelectProfileView() {
        present(picker, animated: true, completion: nil)
    }
    
    // textfield func for the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nameTextField.resignFirstResponder()
        self.ingredientsTextField.resignFirstResponder()
        self.instructionsTextField.resignFirstResponder()
        return true;
    }
    
    // disappear keyboard when tap somehere else in the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func submit(_ sender: Any) {
        
        guard let name = nameTextField.text, !name.isEmpty else {
            let alertError = UIAlertController(title: "Name Input Error", message: "Correct data input is required.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
            return
        }
        
        guard let ingred = ingredientsTextField.text, !ingred.isEmpty else {
            let alertError = UIAlertController(title: "Ingredients Input Error", message: "Correct data input is required.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
            return
        }
        
        guard let instruct = instructionsTextField.text, !instruct.isEmpty else {
            let alertError = UIAlertController(title: "Instructions Input Error", message: "Correct data input is required.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
            return
        }
        
        if self.selImage != nil {
            let userID = Auth.auth().currentUser?.uid
            
            let storageRef = Storage.storage().reference(forURL: "gs://fearfitaz.appspot.com").child("recipe_view").child(userID!)
            
            if let recipeImage = self.selImage, let imageData = recipeImage.jpegData(compressionQuality: 1.0) {
                
                storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        return
                    }
                    let recipeImageURL = metadata?.downloadURL()?.absoluteString
                    // https://www.youtube.com/watch?v=z0-ME5HYook
                    // video for reference point
                    
                    // location that ties to the firebase database
                    let ref = Database.database().reference()
                    
                    let usersReference = ref.child("recipes")
                    let newUserReference = usersReference.child(userID!)
                    // keep the password a secret!
                    newUserReference.setValue(["userid": userID, "name": name, "ingredients": ingred, "instruct": instruct, "image": recipeImageURL])
                    
                    self.performSegue(withIdentifier: "addRecipeToVC", sender: nil)
                })
            }
        } else {
            let alertError = UIAlertController(title: "Image Input Error", message: "Please upload an image.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addRecipeToVC") {
            print(segue.destination)
            let navController = segue.destination as! UINavigationController
            if let viewController: RecipeTableViewController = navController.topViewController as! RecipeTableViewController {
                
                guard let name = nameTextField.text, !name.isEmpty else {
                    let alertError = UIAlertController(title: "Name Input Error", message: "Correct data input is required.", preferredStyle: .alert)
                    
                    alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alertError, animated: true)
                    return
                }
                
                guard let ingred = ingredientsTextField.text, !ingred.isEmpty else {
                    let alertError = UIAlertController(title: "Ingredients Input Error", message: "Correct data input is required.", preferredStyle: .alert)
                    
                    alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alertError, animated: true)
                    return
                }
                
                guard let instruct = instructionsTextField.text, !instruct.isEmpty else {
                    let alertError = UIAlertController(title: "Instructions Input Error", message: "Correct data input is required.", preferredStyle: .alert)
                    
                    alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alertError, animated: true)
                    return
                }
                
                if self.selImage != nil {
                    //                    let userID = Auth.auth().currentUser?.uid
                    //
                    //                    let storageRef = Storage.storage().reference(forURL: "gs://fearfitaz.appspot.com").child("recipe_view").child(userID!)
                    //
                    //                    if let recipeImage = self.selImage, let imageData = recipeImage.jpegData(compressionQuality: 1.0) {
                    //
                    //                        storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    //                            if error != nil {
                    //                                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    //
                    //                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    //                                self.present(alert, animated: true)
                    //                                return
                    //                            }
                    //                            let recipeImageURL = metadata?.downloadURL()?.absoluteString
                    //                            // https://www.youtube.com/watch?v=z0-ME5HYook
                    //                            // video for reference point
                    //
                    //                            // location that ties to the firebase database
                    //                            let ref = Database.database().reference()
                    //
                    //                            let usersReference = ref.child("recipes")
                    //                            let newUserReference = usersReference.child(userID!)
                    //                            // keep the password a secret!
                    //                            newUserReference.setValue(["userid": userID, "name": name, "ingredients": ingred, "instruct": instruct, "image": recipeImageURL])
                    //
                    //                            self.performSegue(withIdentifier: "addRecipeToVC", sender: nil)
                    //                        })
                    var toAdd = recipe(n: name, i: self.selImage!, ins: instruct, ing: ingred)
                    viewController.recipeInfo.add(rec: toAdd)
                }
            } else {
                let alertError = UIAlertController(title: "Image Input Error", message: "Please upload an image.", preferredStyle: .alert)
                
                alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alertError, animated: true)
            }
        }
    }
}

extension AddRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        selImage = selectedImage
        foodImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
