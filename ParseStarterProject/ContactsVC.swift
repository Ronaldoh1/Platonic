//
//  ContactsVC.swift
//  Platonic
//
//  Created by Ronald Hernandez on 9/14/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ContactsVC: UITableViewController {
    var contactsArray = [String]()
    var userImagesArray = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()


     self.downloadContacts()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onDoneButtonTapped(sender: UIBarButtonItem) {

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.contactsArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.text = self.contactsArray[indexPath.row]
        
        if self.userImagesArray.count > indexPath.row {
            cell.imageView?.image = self.userImagesArray[indexPath.row];

        }




        return cell
    }

    //Helper methods

    func downloadContacts(){

        let query = User.query()
        //Check if they have accepted us
        query?.whereKey("chosenArray", equalTo: (PFUser.currentUser()?.objectId)!)

        //check if we have accepted them. Where their objectId is contained in our "chosenArray

        query?.whereKey("objectId", containedIn: PFUser.currentUser()?["chosenArray"] as! [String])

        query?.findObjectsInBackgroundWithBlock({ (results, error) -> Void in

            for result in results! {

                self.contactsArray.append(result.name)

                let imageFile = result["profileImage"] as! PFFile

                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {

                    imageFile.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in

                        if error != nil {
                            print(error)
                        }else{
                            dispatch_async(dispatch_get_main_queue()) { // 2

                                if let data = imageData {


                                    self.userImagesArray.append(UIImage(data: data)!)

                                    self.tableView.reloadData()



                                }
                            }
                        }
                        
                    })
                })

            }
            self.tableView.reloadData()
        })



    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
