//
//  Contact.swift
//  
//
//  Created by John Cloutier on 6/15/15.
//
//

import Foundation
import CoreData

class Contact: NSManagedObject {

    @NSManaged var email: String
    @NSManaged var phone: String
    @NSManaged var person: Person

}
