//
//  Membership.swift
//  
//
//  Created by John Cloutier on 6/15/15.
//
//

import Foundation
import CoreData

class Membership: NSManagedObject {

    @NSManaged var label: String
    @NSManaged var type: NSNumber
    @NSManaged var person: Person

}
