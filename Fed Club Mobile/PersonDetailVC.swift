//
//  PersonDetailVC.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 6/9/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import Foundation
import UIKit

class PersonDetailVC: UITableViewController {
    
    // Outlets
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var zip: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var ccv: UILabel!
    @IBOutlet weak var membership: UILabel!
    
    
    // Controller Entity
    var person: Person?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Navigation Bar Background Graphic and Title
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "rainbow-header")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
        self.title = person!.firstName + " " + person!.lastName
        
        // Populate Detail View Values from Controller Entity
        firstName.text = person?.firstName
        lastName.text = person?.lastName
        address.text = person?.address.street
        unit.text = person?.address.unit
        city.text = person?.address.city
        state.text = person?.address.state
        zip.text = person?.address.zip
        email.text = person?.contact.email
        phone.text = person?.contact.phone
        cardNumber.text = person?.creditCard.number.stringValue
        ccv.text = person?.creditCard.ccv.stringValue
        membership.text = person?.membership.label

    }
    
    override func viewDidLayoutSubviews() {
        //techDescription.setContentOffset(CGPointZero, animated: false)
    }
    
}