//
//  SuppliersTableViewCell.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/27/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit

class SuppliersTableViewCell: UITableViewCell {
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var supplierMobileNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
