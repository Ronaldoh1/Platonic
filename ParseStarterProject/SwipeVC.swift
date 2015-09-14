//
//  SwipeVC.swift
//  Platonic
//
//  Created by Ronald Hernandez on 9/11/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class SwipeVC: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //we want to download the images and present them to the current user. 
        //w will make a user query call and download based on constraints.

        let query = User.query()

        query?.whereKey("lgbtOnly", equalTo: (PFUser.currentUser()?["lgbtOnly"]!)!)


        query?.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) -> Void in

            if error != nil {
                print(error)
            }else if let objects = objects as?  [PFObject]{
                for object in objects{

                    let imageFile = object["profileImage"] as! PFFile

                    imageFile.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in

                    })


                }

            }

        }

    }


}
