//
//  POSReportViewController.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/29/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit

class POSReportViewController: UIViewController {

    @IBOutlet weak var startingAmountLabel: UILabel!
    
    @IBOutlet weak var closingAmountLabel: UILabel!
    
    @IBOutlet weak var salesLabel: UILabel!
    
    
    @IBOutlet weak var buysLabel: UILabel!
    
    
    @IBOutlet weak var costsLabel: UILabel!
    
    
    
    var startingAmount: String?
    
    var closingAmount: String?
    
    var sales: String?
    
    var buys: String?
    
    var costs: String?
    
    var unit: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startingAmountLabel.text = " Starting Amount: " + startingAmount! + unit!
        
        closingAmountLabel.text = " ClosingAmount: " + closingAmount! + unit!
        
        salesLabel.text = " TotalSales: " + sales! + unit!

        buysLabel.text = " TotalBuys: " + buys! + unit!
        
        costsLabel.text = " TotalCosts: " + costs! + unit!
    }
   
    @IBAction func saveAndReturn(_ sender: UIButton) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
