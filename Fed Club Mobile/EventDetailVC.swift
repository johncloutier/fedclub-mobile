//
//  EventDetailVC.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 6/9/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import Foundation
import UIKit

class EventDetailVC: UITableViewController {
    
    
    var event: Event?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "rainbow-header")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
        
        //url.text = technology!.url
        //pocEmail.text = technology!.pocEmail
        //poc.text = technology!.poc
        //techDescription.text = technology!.techDescription
        //image.image = UIImage(named: technology!.image)
        self.title = event!.name
    }
    
    override func viewDidLayoutSubviews() {
        //techDescription.setContentOffset(CGPointZero, animated: false)
    }
    
}