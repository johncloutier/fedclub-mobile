//
//  CreditCard.swift
//  
//
//  Created by John Cloutier on 6/15/15.
//
//

import Foundation
import CoreData

class CreditCard: NSManagedObject {

    @NSManaged var ccv: NSNumber
    @NSManaged var expDate: NSDate
    @NSManaged var expMonth: NSNumber
    @NSManaged var expYear: NSNumber
    @NSManaged var number: NSNumber
    @NSManaged var person: Person

}
