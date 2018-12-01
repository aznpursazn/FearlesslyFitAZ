//
//  AddSocialViewController.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 11/28/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class AddSocialViewController: UIViewController {
    
    let picker = UIImagePickerController()
    var selImage:UIImage?
    
    @IBOutlet weak var socialImage: UIImageView!
    @IBOutlet weak var descriptionTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        socialImage.layer.cornerRadius = 45
        socialImage.clipsToBounds = true
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(AddSocialViewController.handleSelectProfileView))
        socialImage.addGestureRecognizer(tapGuesture)
        socialImage.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @objc func handleSelectProfileView() {
        present(picker, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.descriptionTextfield.resignFirstResponder()
        return true;
    }
    
    // disappear keyboard when tap somehere else in the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func submit(_ sender: Any) {
        
        guard let d = descriptionTextfield.text, !d.isEmpty else {
            let alertError = UIAlertController(title: "Description Input Error", message: "Correct data input is required.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
            return
        }
        if selImage != nil {
            let userID = Auth.auth().currentUser?.uid
            
            let storageRef = Storage.storage().reference(forURL: "gs://fearfitaz.appspot.com").child("social_view").child(userID!)
            
            if let socialImg = self.selImage, let imageData = socialImg.jpegData(compressionQuality: 1.0) {
                
                storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        return
                    }
                    let socialImageURL = metadata?.downloadURL()?.absoluteString
                    // https://www.youtube.com/watch?v=z0-ME5HYook
                    // video for reference point
                    
                    // location that ties to the firebase database
                    let ref = Database.database().reference()
                    
                    let usersReference = ref.child("socials")
                    let insertSocial = usersReference.child("social")
                    
                    // let newUserReference = usersReference.child(userID!)
                    
                    insertSocial.setValue(["userid": userID, "description": d, "socialImage": socialImageURL])
                    self.performSegue(withIdentifier: "addSocialToVC", sender: nil)
                })
            }
        } else {
            let alertError = UIAlertController(title: "Image Input Error", message: "Correct data input is required.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "addSocialToVC") {
            print(segue.destination)
            let navController = segue.destination as! UINavigationController
            if let viewController: SocialTableViewController = navController.topViewController as! SocialTableViewController {
                guard let d = descriptionTextfield.text, !d.isEmpty else {
                    let alertError = UIAlertController(title: "Description Input Error", message: "Correct data input is required.", preferredStyle: .alert)
                    
                    alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alertError, animated: true)
                    return
                }
                if self.selImage != nil {
                    //                    let userID = Auth.auth().currentUser?.uid
                    //
                    //                    let storageRef = Storage.storage().reference(forURL: "gs://fearfitaz.appspot.com").child("social_view").child(userID!)
                    //
                    //                    if let socialImg = self.selImage, let imageData = socialImg.jpegData(compressionQuality: 1.0) {
                    //
                    //                        storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    //                            if error != nil {
                    //                                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    //
                    //                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    //                                self.present(alert, animated: true)
                    //                                return
                    //                            }
                    //                            let socialImageURL = metadata?.downloadURL()?.absoluteString
                    //                            // https://www.youtube.com/watch?v=z0-ME5HYook
                    //                            // video for reference point
                    //
                    //                            // location that ties to the firebase database
                    //                            let ref = Database.database().reference()
                    //
                    //                            let usersReference = ref.child("socials")
                    //                            let insertSocial = usersReference.child("social")
                    //
                    //                            // let newUserReference = usersReference.child(userID!)
                    //
                    //                            insertSocial.setValue(["userid": userID, "description": d, "socialImage": socialImageURL])
                    //                        })
                    let toAdd = social(d: d, i: self.selImage!)
                    viewController.socialInfo.add(soc: toAdd)
                }
            }
        } else {
            let alertError = UIAlertController(title: "Image Input Error", message: "Correct data input is required.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
        }
    }
}


extension AddSocialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        selImage = selectedImage
        socialImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
