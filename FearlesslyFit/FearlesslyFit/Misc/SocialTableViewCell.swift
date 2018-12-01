//
//  SocialTableViewCell.swift
//  FearlesslyFit
//
//  Created by Kathy Nguyen on 11/28/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit

class SocialTableViewCell: UITableViewCell {
    
    @IBOutlet weak var socialImage: UIImageView!
    @IBOutlet weak var labelTextfield: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
