//
//  Membership.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 6/15/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import Foundation
import CoreData

@objc(Membership)
class Membership: NSManagedObject {

    @NSManaged var label: String
    @NSManaged var type: NSNumber

}
