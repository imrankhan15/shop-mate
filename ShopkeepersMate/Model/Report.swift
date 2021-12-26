//
//  Report.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/28/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log

class Report: NSObject, NSCoding {

    var staffMobileNumber: String
    var report: String
    var date: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("reports")
    
    //MARK: Types
    
    struct PropertyKey {
        static let staffMobileNumber = "staffMobileNumber"
        static let report = "report"
        static let date = "date"
        
        
    }

    //MARK: Initialization
    
    init?(staffMobileNumber: String, report: String, date: String) {
        
        
        guard !staffMobileNumber.isEmpty else {
            return nil
        }
        guard !report.isEmpty else {
            return nil
        }
        
        guard !date.isEmpty else {
            return nil
        }
        
        
        // Initialize stored properties.
        self.staffMobileNumber = staffMobileNumber
        self.report = report
        self.date = date
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(staffMobileNumber, forKey: PropertyKey.staffMobileNumber)
        aCoder.encode(report, forKey: PropertyKey.report)
        aCoder.encode(date, forKey: PropertyKey.date)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let staffMobileNumber = aDecoder.decodeObject(forKey: PropertyKey.staffMobileNumber) as? String else {
            os_log("Unable to decode the name for a Report object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let report = aDecoder.decodeObject(forKey: PropertyKey.report) as? String else {
            os_log("Unable to decode the name for a Report object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String else {
            os_log("Unable to decode the name for a Report object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        
        // Must call designated initializer.
        self.init(staffMobileNumber: staffMobileNumber, report: report, date: date)
        
    }
    
    

    

    
}
