//
//  ViewController.swift
//  isDogHereApp
//
//  Created by Sina Yeganeh on 27/11/2015.
//  Copyright © 2015 Sina Yeganeh. All rights reserved.
//

import UIKit
import Firebase

class DogViewController: UITableViewController {
    var items = [Dog]()
    let ref = Firebase(url: "https://tunedog.firebaseio.com/Dogs")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableView.allowsMultipleSelectionDuringEditing = false
        // cellImage.layer.cornerRadius = cellImage.frame.size.width/2;
        // Do any additional setup after loading the view, typically from a nib.
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            var newItems = [Dog]()
            
            
            for item in snapshot.children {
                let dogItem = Dog(snapshot: item as! FDataSnapshot)
                newItems.append(dogItem)
            }
            
            self.items = newItems
            self.tableView.reloadData()
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCellWithIdentifier("DogTableCell") as! DogTableCell)
        let dogItem = items[indexPath.row]
        
        let cellImageLayer = cell.dogImage!.layer;
        cellImageLayer.cornerRadius = (cell.dogImage.frame.height)/2
        cellImageLayer.masksToBounds = true
        
        let currentDogName = dogItem.dogName
        if (dogItem.isHere == true) {
            cell.dogName?.textColor = UIColor(red: 0.1, green: 0.8, blue: 0.1, alpha: 1.0)
            cell.dogName?.text = "\(currentDogName) - Here!"
        }
        else if (dogItem.isHere == false) {
            cell.dogName?.textColor = UIColor.redColor()
            cell.dogName?.text = "\(currentDogName) - Not Here :("
        }
        else {
            cell.dogName?.textColor = UIColor.blackColor()
            cell.dogName?.text = "\(currentDogName) - No status yet"
        }
        cell.dogLocation?.text = dogItem.location
        cell.dogImage?.image = dogItem.image
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // If no status, show both buttons.  If here, only show not here.  If not here, only show here
        
        let currentDog = items[indexPath.row]
        
        if (currentDog.isHere == true) {
            let editAction = UITableViewRowAction(style: .Normal, title: "Not Here") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
                //TODO: edit the row at indexPath here
                
                self.ref.childByAppendingPath(currentDog.dogName)
                    .childByAppendingPath("IsHere")
                    .setValue(false)
                
                self.tableView.setEditing(false, animated: true)

            }
            
            editAction.backgroundColor = UIColor.redColor()
            
            return [editAction]
        }
        else if (currentDog.isHere == false) {
            let editAction = UITableViewRowAction(style: .Normal, title: "Here") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
                //TODO: edit the row at indexPath here
                self.ref.childByAppendingPath(currentDog.dogName)
                    .childByAppendingPath("IsHere")
                    .setValue(true)
                
                self.tableView.setEditing(false, animated: true)
            }
            
            editAction.backgroundColor = UIColor(red: 0.1, green: 0.8, blue: 0.1, alpha: 1.0)
            
            return [editAction]
        }
        else {
            
            let editAction = UITableViewRowAction(style: .Normal, title: "Is Here!") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
                //TODO: edit the row at indexPath here
                
                
                
                self.ref.childByAppendingPath(currentDog.dogName)
                    .childByAppendingPath("IsHere")
                    .setValue(true)
                
                self.tableView.setEditing(false, animated: true)
                
                
            }
            editAction.backgroundColor = UIColor(red: 0.1, green: 0.8, blue: 0.1, alpha: 1.0)
            
            
            let editAction2 = UITableViewRowAction(style: .Normal, title: "Not Here") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
                //TODO: edit the row at indexPath here
                
                self.ref.childByAppendingPath(currentDog.dogName)
                    .childByAppendingPath("IsHere")
                    .setValue(false)
                
                tableView.setEditing(false, animated: true)
            }
            editAction2.backgroundColor = UIColor.redColor()
            
            return [editAction, editAction2]
        }
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // Do stuff
        print(editingStyle)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let senderIsTableviewCell:Bool! = sender?.isKindOfClass(UITableViewCell)
        
        if (senderIsTableviewCell != nil) {
            let path = self.tableView.indexPathForSelectedRow!
            let nextSegway = (segue.destinationViewController as! DogDetailsViewController)
            nextSegway.dogDetail = items[path.row]
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

