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
    
    
    @IBOutlet weak var poc: UITextField!
    @IBOutlet weak var pocEmail: UITextField!
    @IBOutlet weak var techDescription: UITextView!
    @IBOutlet weak var url: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    var person: Person?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "rainbow-header")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
        
        //url.text = technology!.url
        //pocEmail.text = technology!.pocEmail
        //poc.text = technology!.poc
        //techDescription.text = technology!.techDescription
        //image.image = UIImage(named: technology!.image)
        self.title = person!.firstName + " " + person!.lastName
    }
    
    override func viewDidLayoutSubviews() {
        //techDescription.setContentOffset(CGPointZero, animated: false)
    }
    
}