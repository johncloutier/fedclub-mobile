//
//  CheckInVC.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 6/7/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import UIKit

class CheckInVC: UIViewController{

        
        var baseBLO = BaseBLO()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Initialize BLO and load list of people
            baseBLO = BaseBLO()
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "rainbow-header")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
            self.navigationController?.navigationBar.translucent = false
        }
        
        override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
        }
    
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "checkInSegue"
            {
                if let destinationVC = segue.destinationViewController as? RSVPListVC{
                }
            }
            else if segue.identifier == "changeEventSegue"
            {
                if let destinationVC = segue.destinationViewController as? EventListVC{
                }
            }
        }
    

    
    
    
    
}

