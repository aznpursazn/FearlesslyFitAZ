//
//  WViewController.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 11/27/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit

class WViewController: UIViewController {
    
    var nw:String?
    var lvl:String?
    var instr:String?

    @IBOutlet weak var nameWorkout: UILabel!
    @IBOutlet weak var levelText: UILabel!
    @IBOutlet weak var instructionsText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameWorkout.text = nw
        levelText.text = lvl
        instructionsText.text = instr
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
