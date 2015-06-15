//
//  PersonListVC.swift
//  Fed Club Mobile
//
//  Created by John Cloutier on 6/7/15.
//  Copyright (c) 2015 John Cloutier. All rights reserved.
//

import UIKit

class PersonListVC: UITableViewController, UISearchResultsUpdating{

        
        var baseBLO = BaseBLO()
        var persons = [Person]()
        var filteredTableData = [Person]()
        var resultSearchController = UISearchController()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Initialize BLO and load list of people
            baseBLO = BaseBLO()
            persons = baseBLO.getAllPersons()
            persons = sorted(persons){ $0.lastName.lowercaseString < $1.lastName.lowercaseString }
            
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
                return persons.count
            }
            
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("personCell") as! UITableViewCell
            if (self.resultSearchController.active && resultSearchController.searchBar.text != "") {
                cell.textLabel?.text = filteredTableData[indexPath.row].firstName + " " + filteredTableData[indexPath.row].lastName
                return cell
            }
            else {
                cell.textLabel?.text = persons[indexPath.row].firstName + " " + persons[indexPath.row].firstName
                return cell
            }
        }
        
        func updateSearchResultsForSearchController(searchController: UISearchController)
        {
            if(searchController.searchBar.text != ""){
                filteredTableData.removeAll(keepCapacity: false)
                let searchPredicate = NSPredicate(format: "SELF.lastName CONTAINS[c] %@ OR SELF.firstName CONTAINS[c] %@", searchController.searchBar.text)
                let array = (persons as NSArray).filteredArrayUsingPredicate(searchPredicate)
                filteredTableData = array as! [Person]
                self.tableView.reloadData()
            } else{
                filteredTableData.removeAll(keepCapacity: false)
                let array = (persons as NSArray)
                filteredTableData = array as! [Person]
                self.tableView.reloadData()
            }
        }
        
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "personDetailSegue"
            {
                if let destinationVC = segue.destinationViewController as? PersonDetailVC{
                    let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
                    if(self.resultSearchController.active){
                        destinationVC.person = filteredTableData[indexPath.row]
                    }else{
                        destinationVC.person = persons[indexPath.row]
                    }
                    resultSearchController.active = false
                }
            }
        }
        
        
        
    
}

