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
    var displayedUserID = ""
    override func viewDidLoad() {
        super.viewDidLoad()


        //create a gesture recognizer - this will allow us to drag the label.
        //The target it's the viewcontroller (self) the selector is "wasDragged:" which is the method that will allow us to drag it.


        let gesture = UIPanGestureRecognizer (target: self, action: Selector("wasDragged:"))

        self.userImage.addGestureRecognizer(gesture)
        self.userImage.userInteractionEnabled = true

        self.updateImage()

            }

    //this is the method that will be called everytime the label is dragged.
    //We care about where we stared and where we ended up. We will create a translation.
    //The information we get back is the location (x,y) form the original center.
    //We want to move the lable to the coordinate

    func wasDragged(gesture: UIPanGestureRecognizer){

        let translation = gesture.translationInView(self.view)
        let label = gesture.view! //we need to force unwrap it because we know there will be a lable that will be obtained from the gesture. It an only be the label that has been panned.

        //CGPoint creates a coordinate pair relative to the bottom left of the screen. translation gives a coordinate relative to the center of the screen.
        //let's start at the center of the screen and get the new coordinate.

        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        //when the user let's go the finger, we need to place the label back to it's location. In tinder, the lable returns back to the center and a new person shows up.

        //keep track of pixles that it has moved.
        let xFromCenter = label.center.x - self.view.bounds.width / 2

        //need a scale to make it smaller

        let scale = min(100 / abs(xFromCenter), 1)

        //the angle is a radian.
        //we need one radian of rotation.
        var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)

        //we need to create our stretch.

        var  stretch = CGAffineTransformScale(rotation, 0.9, 0.9)

        label.transform = stretch





        //do a simple check and if the gesture has ended then simply put the lable back to the center.
        if(gesture.state == UIGestureRecognizerState.Ended){

            var acceptedOrRejected = ""

            //check if the label has been moved to left and closer to the screen, then the user does not want to connect with this person.

            if label.center.x < 100 {
                print("Not Chosen" + self.displayedUserID)

                acceptedOrRejected = "notChosenArray"

                //else if the label has been moved to the right of the screen, then the user user wants to connect with the person.
            }else if label.center.x > self.view.bounds.width - 100 {
                print("Chosen")
                acceptedOrRejected = "chosenArray"
            }

            if acceptedOrRejected != ""{

            PFUser.currentUser()?.addUniqueObjectsFromArray([self.displayedUserID], forKey:acceptedOrRejected)
                PFUser.currentUser()?.save()

            }

            //we need to reset the label back to it's original state.

            rotation = CGAffineTransformMakeRotation(0)
            stretch = CGAffineTransformScale(rotation, 1, 1)
            label.transform = stretch
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)

            self.updateImage()
            
            
        }
        
        
        print(translation);
    }

    func updateImage(){

        // Do any additional setup after loading the view.

        //we want to download the images and present them to the current user.
        //w will make a user query call and download based on constraints.

        let query = User.query()

        query?.whereKey("lgbtOnly", equalTo: (PFUser.currentUser()?["lgbtOnly"]!)!)

        //need to check that the user has not been accepted or rejected.


        var ignoreUsers = [""]



        if let acceptedUsers = PFUser.currentUser()?["chosenArray"]  {

            ignoreUsers += acceptedUsers as! Array



        }


        if let rejectedUsers  = PFUser.currentUser()?["notChosenArray"]  {


         ignoreUsers += rejectedUsers as! Array
            
        }

        query?.whereKey("objectId", notContainedIn: ignoreUsers)

        query?.limit = 1 

        query?.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) -> Void in

            if error != nil {
                print(error)
            }else if let objects = objects as?  [PFObject]{
                for object in objects{

                    self.displayedUserID = object.objectId!

                    let imageFile = object["profileImage"] as! PFFile

                    imageFile.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in

                        if error != nil {
                            print(error)
                        }else{

                            self.userImage.image = UIImage(data: data!)
                        }
                        
                    })
                    
                    
                }
                
            }
            
        }
        

    }


}
