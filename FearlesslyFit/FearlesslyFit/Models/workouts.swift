//
//  workouts.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 11/28/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import Foundation
import UIKit

class workout {
    
    var name:String?
    var level:String?
    var instructions:String?
    
    init(n: String, l: String, i: String) {
        name = n
        level = l
        instructions = i
    }
}

class workouts {
    var workouts:[workout] = []
    
    func getCount() -> Int {
        return workouts.count
    }
    
    func getInfo(row: Int) -> workout {
        return workouts[row]
    }
    
    func add(work: workout) {
        workouts.append(work)
    }
}
