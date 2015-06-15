//
//  Address.swift
//  
//
//  Created by John Cloutier on 6/15/15.
//
//

import Foundation
import CoreData

class Address: NSManagedObject {

    @NSManaged var city: String
    @NSManaged var state: String
    @NSManaged var street: String
    @NSManaged var unit: String
    @NSManaged var zip: String
    @NSManaged var person: Person

}
