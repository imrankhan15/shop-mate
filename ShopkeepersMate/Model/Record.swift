//
//  Record.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/29/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log

class Record: NSObject, NSCoding {
    
    var date: String
    var startingAmount: String
    var endingAmount: String
    var totalBought: String
    var totalSold: String
    var totalOtherCost: String
    var ending: Float
    var unit: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("records")

    //MARK: Types
    
    struct PropertyKey {
        static let date = "date"
        static let startingAmount = "startingAmount"
        static let endingAmount = "endingAmount"
        static let totalBought = "totalBought"
        static let totalSold = "totalSold"
        static let totalOtherCost = "totalOtherCost"
        static let ending = "ending"
        static let unit = "unit"
    }
    
    //MARK: Initialization
    
    init?(date: String, startingAmount: String, endingAmount: String, totalBought: String, totalSold: String, totalOtherCost: String, ending: Float, unit: String) {
        
        
        guard !date.isEmpty else {
            return nil
        }
        guard !startingAmount.isEmpty else {
            return nil
        }
        
        guard !endingAmount.isEmpty else {
            return nil
        }
        
        guard !totalBought.isEmpty else {
            return nil
        }
        guard !totalSold.isEmpty else {
            return nil
        }
        
        guard !totalOtherCost.isEmpty else {
            return nil
        }
        
       
        
        guard !unit.isEmpty else {
            return nil
        }

        
        // Initialize stored properties.
        self.date = date
        self.startingAmount = startingAmount
        self.endingAmount = endingAmount
        self.totalBought = totalBought
        self.totalSold = totalSold
        self.totalOtherCost = totalOtherCost
        self.ending = ending
        self.unit = unit
        
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(startingAmount, forKey: PropertyKey.startingAmount)
        aCoder.encode(endingAmount, forKey: PropertyKey.endingAmount)
        aCoder.encode(totalBought, forKey: PropertyKey.totalBought)
        aCoder.encode(totalSold, forKey: PropertyKey.totalSold)
        aCoder.encode(totalOtherCost, forKey: PropertyKey.totalOtherCost)
        aCoder.encode(ending, forKey: PropertyKey.ending)
         aCoder.encode(unit, forKey: PropertyKey.unit)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String else {
            os_log("Unable to decode the name for a Record object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let startingAmount = aDecoder.decodeObject(forKey: PropertyKey.startingAmount) as? String else {
            os_log("Unable to decode the name for a Record object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let endingAmount = aDecoder.decodeObject(forKey: PropertyKey.endingAmount) as? String else {
            os_log("Unable to decode the name for a Record object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let totalBought = aDecoder.decodeObject(forKey: PropertyKey.totalBought) as? String else {
            os_log("Unable to decode the name for a Record object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let totalSold = aDecoder.decodeObject(forKey: PropertyKey.totalSold) as? String else {
            os_log("Unable to decode the name for a Record object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let totalOtherCost = aDecoder.decodeObject(forKey: PropertyKey.totalOtherCost) as? String else {
            os_log("Unable to decode the name for a Record object.", log: OSLog.default, type: .debug)
            return nil
        }
        
         let ending = aDecoder.decodeFloat(forKey: PropertyKey.ending)
        
        guard let unit = aDecoder.decodeObject(forKey: PropertyKey.unit) as? String else {
            os_log("Unable to decode the name for a Record object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(date: date, startingAmount: startingAmount, endingAmount: endingAmount, totalBought: totalBought, totalSold: totalSold, totalOtherCost: totalOtherCost, ending: ending, unit: unit)
        
    }

    


}
