//
//  Person.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 6/15/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import Foundation
import CoreData

@objc(Person)
class Person: NSManagedObject {

    @NSManaged var firstName: String
    @NSManaged var id: String
    @NSManaged var lastName: String
    @NSManaged var address: Address
    @NSManaged var contact: Contact
    @NSManaged var creditCard: CreditCard
    @NSManaged var membership: Membership

}
