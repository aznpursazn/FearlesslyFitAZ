//
//  socials.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 11/28/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import Foundation
import UIKit

class social {
    
    var description:String
    var image:UIImage
    
    init(d: String, i: UIImage) {
        description = d
        image = i
    }
}

class socials {
    var socials:[social] = []
    
    func getCount() -> Int {
        return socials.count
    }
    
    func getInfo(row: Int) -> social {
        return socials[row]
    }
    
    func add(soc: social) {
        socials.append(soc)
    }
}
