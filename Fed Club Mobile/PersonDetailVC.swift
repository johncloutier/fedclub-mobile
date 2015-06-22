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
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var unit: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var expDate: UITextField!
    @IBOutlet weak var ccv: UITextField!
    @IBOutlet weak var membership: UITextField!
    

    
    // Controller Entities
    var person: Person?
    var isnew = false
    var svc = DBService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Navigation Bar Background Graphic and Title
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "rainbow-header")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
        
        // Populate Detail View Values from Controller Entity
        if(person != nil){
            firstName.text = person?.firstName
            lastName.text = person?.lastName
            street.text = person?.address.street
            unit.text = person?.address.unit
            city.text = person?.address.city
            state.text = person?.address.state
            zip.text = person?.address.zip
            email.text = person?.contact.email
            phone.text = person?.contact.phone
            cardNumber.text = person?.creditCard.number.stringValue
            expDate.text = person?.creditCard.number.stringValue
            ccv.text = person?.creditCard.ccv.stringValue
            membership.text = person?.membership.label
            self.title = person!.firstName + " " + person!.lastName
        }else{
            self.title = "New Person"
        }


    }
    
    override func viewDidLayoutSubviews() {
        //techDescription.setContentOffset(CGPointZero, animated: false)
    }

    
    @IBAction func save(sender: UIButton) {
        let newPerson = svc.getNewEntityByType("Person") as! Person
        let newAddress = svc.getNewEntityByType("Address") as! Address
        let newContact = svc.getNewEntityByType("Contact") as! Contact
        let newCreditCard = svc.getNewEntityByType("CreditCard") as! CreditCard
        
        newPerson.firstName = firstName.text
        newPerson.lastName = lastName.text
        newPerson.address.street = street.text
        newPerson.address.unit = unit.text
        newPerson.address.city = city.text
        newPerson.address.state = state.text
        newPerson.address.zip = zip.text
        newPerson.contact.email = email.text
        newPerson.contact.phone = phone.text
        newPerson.creditCard.expDate = expDate.text
        
        println(cardNumber.text)
        
        if cardNumber.text != "" {
            newPerson.creditCard.number = cardNumber.text.toInt()!
        }
        if ccv.text != "" {
            newPerson.creditCard.ccv = ccv.text.toInt()!
        }
        
        newPerson.membership.label = membership.text
        svc.saveContext()
        
        let parent = self.presentingViewController as? UITableViewController
        parent?.tableView.reloadData()
        
        self.navigationController?.popViewControllerAnimated(true)

    }
    
    @IBAction func cancel(sender: UIButton) {
    }
    
    
    
}