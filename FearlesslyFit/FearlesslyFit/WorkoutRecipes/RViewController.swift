//
//  RViewController.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 11/27/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit

class RViewController: UIViewController {
    
    var fi:UIImage?
    var nr:String?
    var ing:String?
    var ins:String?

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var nameOfRecipe: UITextView!
    @IBOutlet weak var ingredientsText: UITextView!
    @IBOutlet weak var instructionsText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodImage.image = fi
        nameOfRecipe.text = nr
        ingredientsText.text = ing
        instructionsText.text = ins
        // Do any additional setup after loading the view.
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
