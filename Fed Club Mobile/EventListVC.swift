//
//  EventListVC.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 6/7/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import UIKit

class EventListVC: UITableViewController, UISearchResultsUpdating{

        
        var baseBLO = BaseBLO()
        var events = [Event]()
        var filteredTableData = [Event]()
        var resultSearchController = UISearchController()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Initialize BLO and load list of people
            baseBLO = BaseBLO()
            events = baseBLO.getAllEvents()
            events = sorted(events){ $0.name.lowercaseString < $1.name.lowercaseString }
            
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
                return events.count
            }
            
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("eventCell") as! UITableViewCell
            if (self.resultSearchController.active && resultSearchController.searchBar.text != "") {
                cell.textLabel?.text = filteredTableData[indexPath.row].name
                return cell
            }
            else {
                cell.textLabel?.text = events[indexPath.row].name
                return cell
            }
        }
        
        func updateSearchResultsForSearchController(searchController: UISearchController)
        {
            if(searchController.searchBar.text != ""){
                filteredTableData.removeAll(keepCapacity: false)
                let searchPredicate = NSPredicate(format: "SELF.name CONTAINS[c] %@", searchController.searchBar.text)
                let array = (events as NSArray).filteredArrayUsingPredicate(searchPredicate)
                filteredTableData = array as! [Event]
                self.tableView.reloadData()
            } else{
                filteredTableData.removeAll(keepCapacity: false)
                let array = (events as NSArray)
                filteredTableData = array as! [Event]
                self.tableView.reloadData()
            }
        }
        
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "eventDetailSegue"
            {
                if let destinationVC = segue.destinationViewController as? EventDetailVC{
                    let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
                    if(self.resultSearchController.active){
                        destinationVC.event = filteredTableData[indexPath.row]
                    }else{
                        destinationVC.event = events[indexPath.row]
                    }
                    resultSearchController.active = false
                }
            }
        }
        
        
        
    
}

