//
//  RecordItemViewController.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/30/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import GoogleMobileAds


class RecordItemViewController: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
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

        bannerView.adUnitID = "ca-app-pub-4598488303993049/2689091688"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        date.text =  dateTime!
        
        startingAmountLabel.text = startingAmount
        
        closingAmountLabel.text = closingAmount
        
        totalSales.text = sales
        
        totalBuys.text = buys
        
        totalOtherCost.text = cost
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
