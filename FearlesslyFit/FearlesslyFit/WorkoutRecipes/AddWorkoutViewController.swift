//
//  AddWorkoutViewController.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 11/27/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AddWorkoutViewController: UIViewController {
    
    var workInfo:workouts = workouts()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var levelTextField: UITextField!
    @IBOutlet weak var instructionsTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submit(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else {
            let alertError = UIAlertController(title: "Name Input Error", message: "Correct data input is required.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
            return
        }
        
        guard let level = levelTextField.text, !name.isEmpty else {
            let alertError = UIAlertController(title: "Level Input Error", message: "Correct data input is required.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
            return
        }
        
        guard let instruct = instructionsTextField.text, !name.isEmpty else {
            let alertError = UIAlertController(title: "Instruction Input Error", message: "Correct data input is required.", preferredStyle: .alert)
            
            alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertError, animated: true)
            return
        }
        
        let userID = Auth.auth().currentUser?.uid
        
        let ref = Database.database().reference()
        
        let usersReference = ref.child("workouts")
        let newUserReference = usersReference.child(userID!)
        // keep the password a secret!
        newUserReference.setValue(["userid": userID, "name": name, "level": level, "instructions": instruct])
        
        let toAdd = workout(n: name, l: level, i: instruct)
        workInfo.add(work: toAdd)
        
        self.performSegue(withIdentifier: "addWorkoutToVC", sender: nil)
    }
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addWorkoutToVC") {
            print(segue.destination)
            let navController = segue.destination as! UINavigationController
            if let viewController: WorkoutTableViewController = navController.topViewController as! WorkoutTableViewController {
                
                guard let name = nameTextField.text, !name.isEmpty else {
                    let alertError = UIAlertController(title: "Name Input Error", message: "Correct data input is required.", preferredStyle: .alert)
                    
                    alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alertError, animated: true)
                    return
                }
                
                guard let level = levelTextField.text, !name.isEmpty else {
                    let alertError = UIAlertController(title: "Level Input Error", message: "Correct data input is required.", preferredStyle: .alert)
                    
                    alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alertError, animated: true)
                    return
                }
                
                guard let instruct = instructionsTextField.text, !name.isEmpty else {
                    let alertError = UIAlertController(title: "Instruction Input Error", message: "Correct data input is required.", preferredStyle: .alert)
                    
                    alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alertError, animated: true)
                    return
                }
                
//                let userID = Auth.auth().currentUser?.uid
//
//                let ref = Database.database().reference()
//
//                let usersReference = ref.child("workouts")
//                let newUserReference = usersReference.child(userID!)
//                // keep the password a secret!
//                newUserReference.setValue(["userid": userID, "name": name, "level": level, "instructions": instruct])
//
                let toAdd = workout(n: name, l: level, i: instruct)
                
                viewController.workInfo.add(work: toAdd)
            }
        }
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
    
}
