//
//  ProfileViewController.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 10/30/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ProfileViewController: UIViewController {
    
    var username:String!
    var image:UIImage!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.layer.cornerRadius = 70
        userImage.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async() {
        let ref = Database.database().reference(fromURL: "https://fearfitaz.firebaseio.com/")
        let userID = Auth.auth().currentUser?.uid
        let usersRef = ref.child("users").child(userID!).observe(.value, with: { snapshot in
            let dict = snapshot.value as! [String: Any]
            self.username = dict["username"] as? String
            
            let storageRef = Storage.storage().reference(forURL: "gs://fearfitaz.appspot.com").child("user_Image").child(userID!)
            
            storageRef.getData(maxSize: 5 * 1024 * 1024, completion: { metadata, err in
                if err != nil {
                    return
                }
                self.image = UIImage(data: metadata!)
                self.userImage.image = self.image
                self.usernameLabel.text = "Welcome " + self.username
            })
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
    
}
