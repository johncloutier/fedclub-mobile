//
//  Event.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 6/15/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import Foundation
import CoreData

@objc(Event)
class Event: NSManagedObject {

    @NSManaged var date: String
    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var venue: String

}
