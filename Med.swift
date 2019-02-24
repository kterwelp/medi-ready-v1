//
//  Med.swift
//  Medi Ready v2
//
//  Created by Kevin Terwelp on 2/19/19.
//  Copyright © 2019 Kevin Terwelp. All rights reserved.
//

import UIKit
import os.log

class Med : NSObject, NSCoding {
    
    //MARK: Properties
    
    var med: String
    var tabDose : String
    var rxNum : String
    var dose : String
    var tabPerDose : String
    var route : String
    var frequency : String
    var numOfDays : String
    var dx : String
    var comments : String
    
    init?(med: String, tabDose: String, rxNum : String, dose : String, tabPerDose : String, route : String, frequency : String, numOfDays : String, dx : String, comments: String) {
        
        //The name and tabDose must not be empty.
        guard !med.isEmpty || !tabDose.isEmpty ||
            !dose.isEmpty || !tabPerDose.isEmpty ||
            !route.isEmpty || !frequency.isEmpty ||
            !dx.isEmpty else{
            return nil
        }
        
        //Initialize stored properties.
        self.med = med
        self.tabDose = tabDose
        self.rxNum = rxNum
        self.dose = dose
        self.tabPerDose = tabPerDose
        self.route = route
        self.frequency = frequency
        self.numOfDays = numOfDays
        self.dx = dx
        self.comments = comments
        
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meds")
    
    //MARK: Types
    
    struct PropertyKey {
        static let med = "med"
        static let tabDose = "tabDose"
        static let rxNum = "rxNum"
        static let dose = "dose"
        static let tabPerDose = "tabPerDose"
        static let route = "route"
        static let frequency = "frequency"
        static let numOfDays = "numOfDays"
        static let dx = "dx"
        static let comments = "comments"
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(med, forKey: PropertyKey.med)
        aCoder.encode(tabDose, forKey: PropertyKey.tabDose)
        aCoder.encode(rxNum, forKey: PropertyKey.rxNum)
        aCoder.encode(dose, forKey: PropertyKey.dose)
        aCoder.encode(tabPerDose, forKey: PropertyKey.tabPerDose)
        aCoder.encode(route, forKey: PropertyKey.route)
        aCoder.encode(frequency, forKey: PropertyKey.frequency)
        aCoder.encode(numOfDays, forKey: PropertyKey.numOfDays)
        aCoder.encode(dx, forKey: PropertyKey.dx)
        aCoder.encode(comments, forKey: PropertyKey.comments)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        //The med is required. If we cannot decode a med string, the initializer should fail
        guard let med = aDecoder.decodeObject(forKey: PropertyKey.med) as? String
            else {
                
                os_log("Unable to decode the med for a Med object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        //The tabDose is required. If we cannot decode a tabDose string, the initializer should fail
        guard let tabDose = aDecoder.decodeObject(forKey: PropertyKey.tabDose) as? String
            else {
                
                os_log("Unable to decode the tabDose for a Med object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        //The med is required. If we cannot decode a med string, the initializer should fail
        guard let rxNum = aDecoder.decodeObject(forKey: PropertyKey.rxNum) as? String
            else {
                
                os_log("Unable to decode the rxNum for a Med object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        //The med is required. If we cannot decode a med string, the initializer should fail
        guard let dose = aDecoder.decodeObject(forKey: PropertyKey.dose) as? String
            else {
                
                os_log("Unable to decode the dose for a Med object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        //The med is required. If we cannot decode a med string, the initializer should fail
        guard let tabPerDose = aDecoder.decodeObject(forKey: PropertyKey.tabPerDose) as? String
            else {
                
                os_log("Unable to decode the tabPerDose for a Med object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        //The med is required. If we cannot decode a med string, the initializer should fail
        guard let route = aDecoder.decodeObject(forKey: PropertyKey.route) as? String
            else {
                
                os_log("Unable to decode the route for a Med object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        //The med is required. If we cannot decode a med string, the initializer should fail
        guard let frequency = aDecoder.decodeObject(forKey: PropertyKey.frequency) as? String
            else {
                
                os_log("Unable to decode the frequency for a Med object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        //The med is required. If we cannot decode a med string, the initializer should fail
        guard let dx = aDecoder.decodeObject(forKey: PropertyKey.dx) as? String
            else {
                
                os_log("Unable to decode the dx for a Med object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        //Because numOfDays is an optional property of Med, just use conditional cast.
        let numOfDays = aDecoder.decodeObject(forKey: PropertyKey.numOfDays) as? String
        
        //Because comments is an optional property of Med, just use conditional cast.
        let comments = aDecoder.decodeObject(forKey: PropertyKey.comments) as? String
        
        //Must call designated initializer.
        self.init(med: med, tabDose: tabDose, rxNum: rxNum, dose: dose, tabPerDose: tabPerDose, route: route, frequency: frequency, numOfDays: numOfDays!, dx: dx, comments: comments!)
    }
}
