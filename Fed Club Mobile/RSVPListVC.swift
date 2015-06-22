//
//  RsvpListVC.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 6/7/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import UIKit

class RSVPListVC: UITableViewController, UISearchResultsUpdating{
    
    
    var baseBLO = BaseBLO()
    var rsvps = [RSVP]()
    var filteredTableData = [RSVP]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize BLO and load list of people
        rsvps = baseBLO.getAllRSVPs()
        rsvps = sorted(rsvps){ $0.person.lastName.lowercaseString < $1.person.lastName.lowercaseString }
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "rainbow-header")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
        self.navigationController?.navigationBar.translucent = false
        
        // Reload the table
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.resultSearchController.active) {
            return self.filteredTableData.count
        }
        else {
            return rsvps.count
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("personCell") as! UITableViewCell
        if (self.resultSearchController.active && resultSearchController.searchBar.text != "") {
            cell.textLabel?.text = filteredTableData[indexPath.row].person.firstName + " " + filteredTableData[indexPath.row].person.lastName
            return cell
        }
        else {
            cell.textLabel?.text = rsvps[indexPath.row].person.firstName + " " + rsvps[indexPath.row].person.firstName
            return cell
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        if(searchController.searchBar.text != ""){
            filteredTableData.removeAll(keepCapacity: false)
            let searchPredicate = NSPredicate(format: "SELF.name CONTAINS[c] %@", searchController.searchBar.text)
            let array = (rsvps as NSArray).filteredArrayUsingPredicate(searchPredicate)
            filteredTableData = array as! [RSVP]
            self.tableView.reloadData()
        } else{
            filteredTableData.removeAll(keepCapacity: false)
            let array = (rsvps as NSArray)
            filteredTableData = array as! [RSVP]
            self.tableView.reloadData()
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "rsvpPersonInfoSegue"
        {
            if let destinationVC = segue.destinationViewController as? PersonDetailVC{
                let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
                if(self.resultSearchController.active){
                    destinationVC.person = filteredTableData[indexPath.row].person
                }else{
                    destinationVC.person = rsvps[indexPath.row].person
                }
                resultSearchController.active = false
            }
        }
        else if segue.identifier == "addNewPersonSegue"
        {
            if let destinationVC = segue.destinationViewController as? PersonDetailVC{
                //destinationVC.person = svc.getNewEntityByType("Person") as! Person
                resultSearchController.active = false
            }
        }
    }
    
    
    
}

