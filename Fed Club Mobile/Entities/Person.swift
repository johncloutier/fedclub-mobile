//
//  Person.swift
//  
//
//  Created by John Cloutier on 6/15/15.
//
//

import Foundation
import CoreData

class Person: NSManagedObject {

    @NSManaged var firstName: String
    @NSManaged var id: String
    @NSManaged var lastName: String
    @NSManaged var address: Address
    @NSManaged var contact: Contact
    @NSManaged var creditCard: CreditCard
    @NSManaged var membership: Membership

}
