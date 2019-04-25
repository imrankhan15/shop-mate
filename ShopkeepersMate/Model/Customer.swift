//
//  Customer.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/26/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log

class Customer: NSObject, NSCoding {
    
    var customerName: String
    var customerMobileNumber: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("customers")
    
    //MARK: Types
    
    struct PropertyKey {
        static let customerName = "customerName"
        static let customerMobileNumber = "customerMobileNumber"
        
        
    }
    
    //MARK: Initialization
    
    init?(customerName: String, customerMobileNumber: String) {
        
        
        guard !customerName.isEmpty else {
            return nil
        }
        guard !customerMobileNumber.isEmpty else {
            return nil
        }
        
        
        // Initialize stored properties.
        self.customerName = customerName
        self.customerMobileNumber = customerMobileNumber
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(customerName, forKey: PropertyKey.customerName)
        aCoder.encode(customerMobileNumber, forKey: PropertyKey.customerMobileNumber)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let customerName = aDecoder.decodeObject(forKey: PropertyKey.customerName) as? String else {
            os_log("Unable to decode the name for a Customer object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let customerMobileNumber = aDecoder.decodeObject(forKey: PropertyKey.customerMobileNumber) as? String else {
            os_log("Unable to decode the name for a Customer object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        
        
        // Must call designated initializer.
        self.init(customerName: customerName, customerMobileNumber: customerMobileNumber)
        
    }
    

    

}
