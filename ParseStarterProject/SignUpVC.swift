//
//  SignUpVC.swift
//  Platonic
//
//  Created by Ronald Hernandez on 9/9/15.
//  Copyright © 2015 Parse. All rights reserved.
//


import UIKit
import Parse
import FBSDKCoreKit

class SignUpVC: UIViewController {
    @IBOutlet weak var emailTextfield: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


    }

    @IBAction func onSignUpButtonTapped(sender: UIButton) {

        let user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.email = emailTextfield.text

        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                //let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                //Create the AlertController
                let actionSheetController: UIAlertController = UIAlertController(title: "Error Signing Up", message: error.description , preferredStyle: .Alert)

                //Create and add the Cancel action
                let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Cancel) { action -> Void in
                    //Do some stuff


                }
                actionSheetController.addAction(cancelAction)
            } else {
                // Hooray! Let them use the app now.

                let storyboard = UIStoryboard(name: "CompleteProfile", bundle: nil)
                let controller = storyboard.instantiateViewControllerWithIdentifier("completeProfileVC")
                self.presentViewController(controller, animated: true, completion: nil)
            }
        }
    }


    @IBAction func onTermsAndConditionsButtonTapped(sender: AnyObject) {

        let storyboard = UIStoryboard(name: "Policy", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("TermsAndConditionsNavVC")
        
        self.presentViewController(controller, animated: true, completion: nil)


    }

    @IBAction func onCancelButtonTapped(sender: UIButton) {

        self.dismissViewControllerAnimated(true, completion: nil)

    }
}

