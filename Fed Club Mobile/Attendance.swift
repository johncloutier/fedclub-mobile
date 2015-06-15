//
//  Attendance.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 6/15/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import Foundation
import CoreData

@objc(Attendance)
class Attendance: NSManagedObject {

    @NSManaged var event: Event
    @NSManaged var person: Person

}
