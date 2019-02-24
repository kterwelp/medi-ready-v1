//
//  Med.swift
//  Medi Ready
//
//  Created by Kevin Terwelp on 2/19/19.
//  Copyright © 2019 Kevin Terwelp. All rights reserved.
//

import UIKit
import os.log

class Med: NSObject, NSCoding {
    
    //MARK: Properties
    
    var med: String
    var dosePerTablet: String
    var prescribedDose: String
    var tablets: String
    var route: String
    var frequency: String
    var numOfDays: String
    var dx: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meds")
    
    //MARK: Types
    
    struct PropertyKey {
        static let med = "med"
        static let dosePerTablet = "dosePerTablet"
        static let prescribedDose = "prescribedDose"
        static let tablets = "tablets"
        static let route = "route"
        static let frequency = "frequency"
        static let numOfDays = "numOfDays"
        static let dx = "dx"
        
    }
    
    //MARK: Initialization
    
    init?(med: String, dosePerTablet: String, prescribedDose: String, tablets: String, route: String, frequency: String, numOfDays: String, dx: String) {
        
        //Initialization should fail if there is no med.
        if med.isEmpty {
            return nil
        }
        
        self.med = med
        self.dosePerTablet = dosePerTablet
        self.prescribedDose = prescribedDose
        self.tablets = tablets
        self.route = route
        self.frequency = frequency
        self.numOfDays = numOfDays
        self.dx = dx
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(med, forKey: PropertyKey.med)
        aCoder.encode(dosePerTablet, forKey: PropertyKey.dosePerTablet)
        aCoder.encode(prescribedDose, forKey: PropertyKey.prescribedDose)
        aCoder.encode(tablets, forKey: PropertyKey.tablets)
        aCoder.encode(route, forKey: PropertyKey.route)
        aCoder.encode(frequency, forKey: PropertyKey.frequency)
        aCoder.encode(numOfDays, forKey: PropertyKey.numOfDays)
        aCoder.encode(dx, forKey: PropertyKey.dx)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        //The name is required. If we cannot decode a name string, the initializer should fail.
        guard let med = aDecoder.decodeObject(forKey: PropertyKey.med) as? String
            else {
                os_log("Unable to decode the name for a Med object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        guard let prescribedDose = aDecoder.decodeObject(forKey: PropertyKey.prescribedDose) as? String
            else {
                os_log("Unable to decode the prescribedDose for a Med object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        guard let tablets = aDecoder.decodeObject(forKey: PropertyKey.tablets) as? String
            else {
                os_log("Unable to decode the tablets for a Med object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        guard let route = aDecoder.decodeObject(forKey: PropertyKey.route) as? String
            else {
                os_log("Unable to decode the route for a Med object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        guard let frequency = aDecoder.decodeObject(forKey: PropertyKey.frequency) as? String
            else {
                os_log("Unable to decode the frequency for a Med object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        guard let dx = aDecoder.decodeObject(forKey: PropertyKey.dx) as? String
            else {
                os_log("Unable to decode the dx for a Med object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        //Because these are optional properties of Med, just use conditional cast.
        let dosePerTablet = aDecoder.decodeObject(forKey: PropertyKey.dosePerTablet)
        
        let numOfDays = aDecoder.decodeObject(forKey: PropertyKey.numOfDays)
        
        //Must call designated initializer.
        self.init(med: med, dosePerTablet: dosePerTablet as! String, prescribedDose: prescribedDose, tablets: tablets, route: route, frequency: frequency, numOfDays: numOfDays as! String, dx: dx)
    }
    
}
