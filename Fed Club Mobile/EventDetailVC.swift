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
    
    // Outlets
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var attendees: UILabel!
    @IBOutlet weak var rsvps: UILabel!
    @IBOutlet weak var openRsvps: UILabel!
    
    // Controller Entity
    var event: Event?
    
    // Attendee Count Summary
    var attendeeCount:  NSNumber = 0
    var rsvpCount:  NSNumber = 0
    var openRsvpCount:  NSNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Navigation Bar Background Graphic and Title
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "rainbow-header")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
        self.title = event!.name
        
        // Count Up Attendees
        
        // Populate Detail View Values from Controller Entity
        name.text = event?.name
        venue.text = event?.venue
        id.text = event?.id.stringValue
        attendees.text = attendeeCount.stringValue
        rsvps.text = rsvpCount.stringValue
        openRsvps.text = openRsvpCount.stringValue
    }
    
    override func viewDidLayoutSubviews() {
        //techDescription.setContentOffset(CGPointZero, animated: false)
    }
    
}