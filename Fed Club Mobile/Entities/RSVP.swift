//
//  RSVP.swift
//  
//
//  Created by John Cloutier on 6/15/15.
//
//

import Foundation
import CoreData

class RSVP: NSManagedObject {

    @NSManaged var event: Event
    @NSManaged var person: Person

}
