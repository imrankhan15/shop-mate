//
//  ViewController.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/26/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var customerButton: UIButton!
    @IBOutlet weak var supplierButton: UIButton!
    @IBOutlet weak var staffButton: UIButton!
    @IBOutlet weak var pointOfSaleButton: UIButton!
    @IBOutlet weak var oldRecordsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customerButton.layer.cornerRadius = 5.0
        supplierButton.layer.cornerRadius = 5.0
        staffButton.layer.cornerRadius = 5.0
        pointOfSaleButton.layer.cornerRadius = 5.0
        oldRecordsButton.layer.cornerRadius = 5.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToHomeView(segue: UIStoryboardSegue) {
        //nothing goes here
    }
    
    
}

