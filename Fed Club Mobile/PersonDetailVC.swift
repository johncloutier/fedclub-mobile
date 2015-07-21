//
//  PersonDetailVC.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 6/9/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import Foundation
import UIKit

class PersonDetailVC: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
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
    var svc: DBService!
    var blo = BaseBLO()
    var memberships: [Membership] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Navigation Bar Background Graphic and Title
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "rainbow-header")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
        
        // Get DBService from AppDelegate
        let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        svc = appDelegate.dbService
        
        // Load Membership Levels
        memberships = blo.getAllMemberships()
        
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
            cardNumber.text = person?.creditCard.number == 0 ? "" : person?.creditCard.number.stringValue
            expDate.text = person?.creditCard.number == 0 ? "" : person?.creditCard.number.stringValue
            ccv.text = person?.creditCard.ccv == 0 ? "" : person?.creditCard.ccv.stringValue
            membership.text = person?.membership.label
            self.title = person!.firstName + " " + person!.lastName
        }else{
            self.title = "New Person"
        }


    }
    
    override func viewDidLayoutSubviews() {
        //techDescription.setContentOffset(CGPointZero, animated: false)
    }

    
    // Button logic for save and cancel
    @IBAction func save(sender: UIButton) {
        if validatePerson(){
            let newPerson = svc.getNewEntityByType("Person") as! Person
            newPerson.address = svc.getNewEntityByType("Address") as! Address
            newPerson.contact = svc.getNewEntityByType("Contact") as! Contact
            newPerson.creditCard = svc.getNewEntityByType("CreditCard") as! CreditCard
            
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
            
            if cardNumber.text != "" {
                newPerson.creditCard.number = cardNumber.text.toInt()!
            }
            if ccv.text != "" {
                newPerson.creditCard.ccv = ccv.text.toInt()!
            }
            
            let searchPredicate = NSPredicate(format: "SELF.label == %@", membership.text)
            newPerson.membership = (memberships as NSArray).filteredArrayUsingPredicate(searchPredicate)[0] as! Membership
            
            svc.saveContext()
            
            let parent = self.presentingViewController as? UITableViewController
            parent?.tableView.reloadData()
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func cancel(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    // Picker Logic for experation date and membership level
    @IBAction func selectDate(sender: UITextField) {
        var datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        datePickerView.backgroundColor = UIColor.whiteColor()

        sender.inputView = datePickerView
        sender.inputAccessoryView = buildPickerMenuBar()
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"
        expDate.text = dateFormatter.stringFromDate(sender.date)
    }
    
    func buildPickerMenuBar() -> UIToolbar {
        var toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = false
        toolBar.sizeToFit()
        
        var emptyButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("closePicker:"))
        
        toolBar.setItems([emptyButton, emptyButton, doneButton], animated: false)
        
        return toolBar
    }
    
    func closePicker(sender: UIBarButtonItem) {
        println(sender.description)
        expDate.resignFirstResponder()
        membership.resignFirstResponder()
    }

    
    @IBAction func selectMembership(sender: UITextField) {
        var membershipPickerView: UIPickerView = UIPickerView()
        membershipPickerView.backgroundColor = UIColor.whiteColor()

        sender.inputAccessoryView = buildPickerMenuBar()
        sender.inputView = membershipPickerView
        
        membershipPickerView.dataSource = self
        membershipPickerView.delegate = self
    }
    
    func numberOfComponentsInPickerView(membershipPicker: UIPickerView) -> Int
    {
        return 1;
    }
    
    func pickerView(membershipPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return memberships.count;
    }
    
    func pickerView(membershipPicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String
    {
        return memberships[row].label
    }
    
    func pickerView(membershipPicker: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        membership!.text = memberships[row].label
    }
    
    
    // Validation Functions
    func validatePerson() -> Bool {
         if !firstName.text.isEmpty &&
            !lastName.text.isEmpty &&
            !email.text.isEmpty {
            showValidationWarning("Please include at least a full name and email address.")
            return false
        }
        
        if !cardNumber.text.isEmpty {
            if expDate.text.isEmpty || count(ccv.text) != 3 || count(cardNumber.text) < 15 {
                showValidationWarning("Please verify credit card information.")
                return false
            }
        }
        
        if membership.text.isEmpty {
            showValidationWarning("Please select a membership level.")
            return false
        }
        
        return true
    }
    
    func showValidationWarning(message: String) {
        let alertController = UIAlertController(title: "Invalid Details", message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // Do something after accepting validation warning
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {
            // Do something after warning appears
        }

    }

}