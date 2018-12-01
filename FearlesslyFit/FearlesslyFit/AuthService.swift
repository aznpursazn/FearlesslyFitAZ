//
//  AuthService.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 11/16/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class AuthService {
    
    static func login(e: String, p: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: e, password: p)
        { (user: User?, error: Error?) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        }
    }
    
    static func signUp(u: String, e: String, p: String, i: Data, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: e, password: p) { (user: User?, error: Error?) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            let uId = user?.uid
            
            // storage class location root location of FB storage
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("user_Image").child(uId!)
            
            storageRef.putData(i, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    onError(error!.localizedDescription)
                    return
                }
                let userImageURL = metadata?.downloadURL()?.absoluteString
                // https://www.youtube.com/watch?v=z0-ME5HYook
                // video for reference point
                
                // location that ties to the firebase database
                let ref = Database.database().reference()
                
                // database is in child
                let uId = user?.uid
                let usersReference = ref.child("users")
                let newUserReference = usersReference.child(uId!)
                // keep the password a secret!
                newUserReference.setValue(["username": u, "email": e, "userImage": userImageURL])
            })
            onSuccess()
        }
        
    }
    
}
