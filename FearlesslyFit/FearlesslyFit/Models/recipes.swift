//
//  recipes.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 11/28/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import Foundation
import UIKit

class recipe {
    
    var name:String?
    var image:UIImage?
    var instructions:String?
    var ingredients:String?
    
    init(n: String, i: UIImage, ins: String, ing: String) {
        name = n
        image = i
        instructions = ins
        ingredients = ing
    }
}

class recipes {
    var recipes:[recipe] = []
    
    func getCount() -> Int {
        return recipes.count
    }
    
    func getInfo(row: Int) -> recipe {
        return recipes[row]
    }
    
    func add(rec: recipe) {
        recipes.append(rec)
    }
}

