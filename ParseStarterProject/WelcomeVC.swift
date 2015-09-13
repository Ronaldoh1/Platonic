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
        self.signInButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.signInButton.layer.borderWidth = 3.0

        self.signUpButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.signUpButton.layer.borderWidth = 3.0


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    let controller = storyboard.instantiateViewControllerWithIdentifier("SwipeVC")
                    self.presentViewController(controller, animated: true, completion: nil)
                }
            } else {
                print("Uh oh. The user cancelled the Facebook login.")
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


