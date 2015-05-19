//
//  MasterGroupsTableViewController.swift
//  SharedTasks
//
//  Created by John Verrone on 5/18/15.
//  Copyright (c) 2015 John Verrone. All rights reserved.
//

import UIKit
import Parse

class MasterGroupsTableViewController: UITableViewController {
    
    var groupObjects: NSMutableArray! = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.fetchAllGroupsFromLocalDatastore()
        self.fetchAllGroups()
    }
    
//    func fetchAllGroupsFromLocalDatastore() {
//        
//        var groupQuery: PFQuery = PFQuery(className: "Group")
//        groupQuery.fromLocalDatastore()
//        groupQuery.whereKey("users", equalTo: PFUser.currentUser()!)
//        groupQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            
//            if (error == nil) {
//                var temp: NSArray = objects! as NSArray
//                self.groupObjects = temp.mutableCopy() as! NSMutableArray
//                self.tableView.reloadData()
//            } else {
//                println(error?.userInfo)
//            }
//            
//        }
//    }
    
    func fetchAllGroups() {
        
        var groupQuery: PFQuery = PFQuery(className: "Group")
        groupQuery.whereKey("users", equalTo: PFUser.currentUser()!)
        groupQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error == nil) {
                println("Successfully retreived \(objects!.count) groups")
                var temp: NSArray = objects! as NSArray
                self.groupObjects = temp.mutableCopy() as! NSMutableArray
                self.tableView.reloadData()
            } else {
                println(error?.userInfo)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.groupObjects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("groupCell", forIndexPath: indexPath) as! UITableViewCell
        
        var object: PFObject = self.groupObjects.objectAtIndex(indexPath.row) as! PFObject
        
        cell.textLabel?.text = object["name"] as? String

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Actions
    
    @IBAction func addGroup(sender: AnyObject) {
        var group: PFObject = PFObject(className: "Group")
        group.setValue("group test", forKey: "name")
        var relation: PFRelation = group.relationForKey("users")
        relation.addObject(PFUser.currentUser()!)
        group.saveEventually({ (success, error) -> Void in
            if (error == nil) {
                self.tableView.reloadData()
            } else {
                println(error?.userInfo)
            }
        })
    }

}
