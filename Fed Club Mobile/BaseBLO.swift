//
//  BaseBLO.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 6/15/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class BaseBLO: NSObject{
    let svc: DBService
    
    override init(){
        let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        svc = appDelegate.dbService!
    }
    
    
    
    func getAllPersons() -> [Person]{
        return svc.getEntityList("Person") as! [Person]
    }
    
    func getAllEvents() -> [Event]{
        return svc.getEntityList("Event") as! [Event]
    }
    
    func getAllRSVPs() -> [RSVP]{
        return svc.getEntityList("RSVP") as! [RSVP]
    }
    
}
