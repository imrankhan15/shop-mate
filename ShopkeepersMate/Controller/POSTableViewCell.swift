//
//  POSTableViewCell.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/29/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit

class POSTableViewCell: UITableViewCell {

    @IBOutlet weak var posDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
