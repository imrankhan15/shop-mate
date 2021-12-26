//
//  CustomersTableViewCell.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/27/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit

class CustomersTableViewCell: UITableViewCell {

    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var customerMobileNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
