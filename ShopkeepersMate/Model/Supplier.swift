//
//  Supplier.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/27/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log

class Supplier: NSObject, NSCoding {
    
    var supplierName: String
    var supplierMobileNumber: String
    var supplierAddress: String
    var suppliedItemType: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("suppliers")
    
    //MARK: Types
    
    struct PropertyKey {
        static let supplierName = "supplierName"
        static let supplierMobileNumber = "supplierMobileNumber"
        static let supplierAddress = "supplierAddress"
        static let suppliedItemType = "suppliedItemType"
    }
    
    //MARK: Initialization
    
    init?(supplierName: String, supplierMobileNumber: String, supplierAddress: String, suppliedItemType: String) {
        
        
        guard !supplierName.isEmpty else {
            return nil
        }
        guard !supplierMobileNumber.isEmpty else {
            return nil
        }
        
        guard !supplierAddress.isEmpty else {
            return nil
        }
        guard !suppliedItemType.isEmpty else {
            return nil
        }
        
        
        // Initialize stored properties.
        self.supplierName = supplierName
        self.supplierMobileNumber = supplierMobileNumber
        self.supplierAddress = supplierAddress
        self.suppliedItemType = suppliedItemType
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(supplierName, forKey: PropertyKey.supplierName)
        aCoder.encode(supplierMobileNumber, forKey: PropertyKey.supplierMobileNumber)
        aCoder.encode(supplierAddress, forKey: PropertyKey.supplierAddress)
        aCoder.encode(suppliedItemType, forKey: PropertyKey.suppliedItemType)

        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let supplierName = aDecoder.decodeObject(forKey: PropertyKey.supplierName) as? String else {
            os_log("Unable to decode the name for a supplier object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let supplierMobileNumber = aDecoder.decodeObject(forKey: PropertyKey.supplierMobileNumber) as? String else {
            os_log("Unable to decode the name for a supplier object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let supplierAddress = aDecoder.decodeObject(forKey: PropertyKey.supplierAddress) as? String else {
            os_log("Unable to decode the name for a supplier object.", log: OSLog.default, type: .debug)
            return nil
        }

        guard let suppliedItemType = aDecoder.decodeObject(forKey: PropertyKey.suppliedItemType) as? String else {
            os_log("Unable to decode the name for a supplier object.", log: OSLog.default, type: .debug)
            return nil
        }

        
        
        // Must call designated initializer.
        self.init(supplierName: supplierName, supplierMobileNumber: supplierMobileNumber, supplierAddress: supplierAddress, suppliedItemType: suppliedItemType)
        
    }
    
    
    

    

    

}
