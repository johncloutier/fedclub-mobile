//
//  CreditCard.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 6/15/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import Foundation
import CoreData

@objc(CreditCard)
class CreditCard: NSManagedObject {

    @NSManaged var ccv: NSNumber
    @NSManaged var expDate: NSDate
    @NSManaged var expMonth: NSNumber
    @NSManaged var expYear: NSNumber
    @NSManaged var number: NSNumber
    @NSManaged var person: Person

}
