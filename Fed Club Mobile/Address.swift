//
//  Address.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 6/15/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import Foundation
import CoreData

@objc(Address)
class Address: NSManagedObject {

    @NSManaged var city: String
    @NSManaged var state: String
    @NSManaged var street: String
    @NSManaged var unit: String
    @NSManaged var zip: String
    @NSManaged var person: Person

}
