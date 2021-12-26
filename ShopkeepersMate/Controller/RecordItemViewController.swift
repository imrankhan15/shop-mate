//
//  RecordItemViewController.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/30/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit



class RecordItemViewController: UIViewController {

   
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var startingAmountLabel: UILabel!
    @IBOutlet weak var closingAmountLabel: UILabel!
    @IBOutlet weak var totalSales: UILabel!
    @IBOutlet weak var totalBuys: UILabel!
    @IBOutlet weak var totalOtherCost: UILabel!
   
    var dateTime: String?
    var startingAmount: String?
    var closingAmount: String?
    var sales: String?
    var buys: String?
    var cost: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date.text =  dateTime!
        startingAmountLabel.text = startingAmount
        closingAmountLabel.text = closingAmount
        totalSales.text = sales
        totalBuys.text = buys
        totalOtherCost.text = cost
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    

    

}
