//
//  StaffsTableViewCell.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/28/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit

class StaffsTableViewCell: UITableViewCell {

    @IBOutlet weak var staffName: UILabel!
    @IBOutlet weak var staffMobileNumber: UILabel!
    @IBOutlet weak var report: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
