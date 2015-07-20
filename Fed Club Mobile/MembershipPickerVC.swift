//
//  MembershipPickerVC.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 7/14/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import Foundation
import UIKit

class MembershipPickerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var blo = BaseBLO()
    var memberships: [Membership] = []
    
    @IBOutlet var membershipPicker:UIPickerView?
    @IBOutlet var membershipField:UITextField?
    
    @IBOutlet var expPicker:UIDatePicker?
    @IBOutlet var expField:UITextField?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        memberships = blo.getAllMemberships()
        self.edgesForExtendedLayout = UIRectEdge.None
        membershipField!.inputView = membershipPicker
        expField!.inputView = expPicker
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
        return memberships[row].description
    }
    
    func pickerView(membershipPicker: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        membershipField!.text = memberships[row].description
    }
    
    func textFieldDidBeginEditing(textField:UITextField)
    {
        self.membershipField!.text = memberships[0].description
        expField!.text = NSDate().description
    }
    
    @IBAction func dateValueChanged(sender:UIDatePicker)
    {
        expField!.text = sender.date.description
    }
}