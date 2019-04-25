//
//  Staff.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/28/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log

class Staff: NSObject, NSCoding {

    var staffName: String
    var staffMobileNumber: String
    var staffAddress: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("staffs")
    
    //MARK: Types
    
    struct PropertyKey {
        static let staffName = "staffName"
        static let staffMobileNumber = "staffMobileNumber"
        static let staffAddress = "staffAddress"
        
        
    }
    
    //MARK: Initialization
    
    init?(staffName: String, staffMobileNumber: String, staffAddress: String) {
        
        
        guard !staffName.isEmpty else {
            return nil
        }
        guard !staffMobileNumber.isEmpty else {
            return nil
        }
        
        guard !staffAddress.isEmpty else {
            return nil
        }
        
        
        // Initialize stored properties.
        self.staffName = staffName
        self.staffMobileNumber = staffMobileNumber
        self.staffAddress = staffAddress
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(staffName, forKey: PropertyKey.staffName)
        aCoder.encode(staffMobileNumber, forKey: PropertyKey.staffMobileNumber)
        aCoder.encode(staffAddress, forKey: PropertyKey.staffAddress)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let staffName = aDecoder.decodeObject(forKey: PropertyKey.staffName) as? String else {
            os_log("Unable to decode the name for a Staff object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let staffMobileNumber = aDecoder.decodeObject(forKey: PropertyKey.staffMobileNumber) as? String else {
            os_log("Unable to decode the name for a Staff object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let staffAddress = aDecoder.decodeObject(forKey: PropertyKey.staffAddress) as? String else {
            os_log("Unable to decode the name for a Report object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        
        // Must call designated initializer.
        self.init(staffName: staffName, staffMobileNumber: staffMobileNumber, staffAddress: staffAddress)
        
    }
    
}
