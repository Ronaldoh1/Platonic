//
//  WelcomeVC.swift
//  Platonic
//
//  Created by Ronald Hernandez on 9/9/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit

class WelcomeVC:  UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!



    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view, typically from a nib.
        self.signInButton.layer.borderColor = UIColor(red: 0/255.0, green: 201/255.0, blue: 132/255.0, alpha: 1).CGColor;
        self.signInButton.layer.borderWidth = 3.0


        self.signUpButton.layer.borderColor = UIColor(red: 0/255.0, green: 201/255.0, blue: 132/255.0, alpha: 1).CGColor;

        self.signUpButton.layer.borderWidth = 3.0


//        let urlArray = ["http://static.comicvine.com/uploads/original/11111/111113908/3006275-cyclops_dialogue_3.png", "http://cscdn.marvelheroes.com/costume/en/Store_Rogue_Savagelands.png", "http://www.geekoutpost.com/wp-content/uploads/2015/07/storm_feature.jpg", "http://static.comicvine.com/uploads/original/11113/111130700/3535916-8192069448-wolve.jpg"]
//
//
//        let user:PFUser = PFUser()
//
//        var counter = 1
//
//        for url in urlArray{
//
//            let nsurl = NSURL(string: url)
//
//            if let data = NSData(contentsOfURL: nsurl!){
//
//              //  self.profileImage.image = UIImage(data: data)
//
//                let imageFile:PFFile = PFFile(data: data)
//
//
//                user["profileImage"] = imageFile
//                user["gender"] = "Female"
//                user["lgbtOnly"] = false
//                user.username = "user\(counter)"
//                user.password = "pass"
//                
//                counter++
//                
//                user.signUp()
//            }
//            
//
//
//
//    }



    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)


       let currentUser = PFUser.currentUser()?.username




        if currentUser != nil {
            // Do stuff with the user
            let storyboard = UIStoryboard(name: "Swipe", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("SwipeNavBarVC")
            self.presentViewController(controller, animated: true, completion: nil)

        }
    }


    @IBAction func onSignInWithFacebookButtonTapped(sender: AnyObject) {


        let permissions = ["public_profile", "email"]

        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    print("User signed up and logged in through Facebook!")

                    let storyboard = UIStoryboard(name: "CompleteProfile", bundle: nil)
                    let controller = storyboard.instantiateViewControllerWithIdentifier("completeProfileVC")
                    self.presentViewController(controller, animated: true, completion: nil)
                    
                } else {
                    print("User logged in through Facebook!")

                    let storyboard = UIStoryboard(name: "Swipe", bundle: nil)
                    let controller = storyboard.instantiateViewControllerWithIdentifier("SwipeNavBarVC")
                    self.presentViewController(controller, animated: true, completion: nil)
                }
            } else {
                print("Uh oh. The user cancelled the Facebook login.")


                //Create the AlertController
                let actionSheetController: UIAlertController = UIAlertController(title: "Sign in Cancelled", message: "Uh oh. The user cancelled the Facebook login.", preferredStyle: .Alert)

                //Create and add the Cancel action
                let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Cancel) { action -> Void in
                    //Do some stuff


                }
                actionSheetController.addAction(cancelAction)


                
                //Present the AlertController
                self.presentViewController(actionSheetController, animated: true, completion: nil)

            }
        }




    }
    @IBAction func onSignInWithTwitterButtonTapped(sender: AnyObject) {


    }
    @IBAction func onSignInButtonTapped(sender: AnyObject) {

        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("SignInVC")
        self.presentViewController(controller, animated: true, completion: nil)

        
    }
    @IBAction func onSignUpButtonTapped(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("SignUpVC") 
        self.presentViewController(controller, animated: true, completion: nil)

    }
}


