//
//  DBLoader.swift
//  Capital Pride
//
//  Created by John Cloutier on 5/4/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DBLoader: NSObject{
    
    let svc: DBService
    
    override init(){
        let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        svc = appDelegate.dbService!
    }
    
    func loadDB(){
        if dbEmpty(){
            loadMemberships()
            svc.saveContext()
        }
    }
    
    func dbEmpty() -> Bool{
        let list: [NSManagedObject] = svc.getEntityList("Membership")!
        
        if list.count == 0 {
            return true
        }else{
            return false
        }
    }
    
    func loadMemberships(){
        let member1: Membership = svc.getNewEntityByType("Membership") as! Membership
        member1.type = 0
        member1.label = "Non-Member"
        
        let member2: Membership = svc.getNewEntityByType("Membership") as! Membership
        member2.type = 1
        member2.label = "Member"
        
        let member3: Membership = svc.getNewEntityByType("Membership") as! Membership
        member3.type = 2
        member3.label = "Fed Club"
        
        let member4: Membership = svc.getNewEntityByType("Membership") as! Membership
        member4.type = 3
        member4.label = "Major Donor"
    }
    
    func loadEvents(){
        let event1: Event = svc.getNewEntityByType("Event") as! Event
        event1.name = "Fed Club Happy Hour"
        event1.venue = "Brixton"
        event1.date = NSDate()
        event1.id = 123456789
        
        let event2: Event = svc.getNewEntityByType("Event") as! Event
        event2.name = "Bear Happy Hour"
        event2.venue = "Town"
        event2.date = NSDate()
        event2.id = 234567890
        
        let event3: Event = svc.getNewEntityByType("Event") as! Event
        event3.name = "Night at Nellies"
        event3.venue = "Nellies"
        event3.date = NSDate()
        event3.id = 345678901
    }
    
    
    func parseTabSeperated(fileName: String, fileType: String, columns: Int) -> [[String]]{
        var array = [String]()
        var objs = [[String]]()
        var bad = [[String]]()
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
        
        if let content = String(contentsOfFile:path!, encoding: NSUTF8StringEncoding, error: nil) {
            array = content.componentsSeparatedByString("--newline--\n")
        }
        
        for line in array{
            let row: [String] = split(line, allowEmptySlices: true, isSeparator: {$0 == "\t"})
            if row.count == columns {
                objs.append(row)
            }else{
                println("Bad line in " + fileName + " not added to DB: " + line)
            }
        }
        return objs
    }
    
    
}