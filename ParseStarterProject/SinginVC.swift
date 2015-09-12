//
//  SinginVC.swift
//  Platonic
//
//  Created by Ronald Hernandez on 9/9/15.
//  Copyright © 2015 Parse. All rights reserved.
//


import UIKit
import Parse
import FBSDKCoreKit

class SignInVC: UIViewController{
     var inputTextField: UITextField?

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }
    
    @IBAction func onCancelButtonTapped(sender: UIButton) {

        self.dismissViewControllerAnimated(true, completion: nil)


    }
    @IBAction func onSignInButtonTapped(sender: UIButton) {

        PFUser.logInWithUsernameInBackground(self.username.text!, password:self.password.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.

                let storyboard = UIStoryboard(name: "Swipe", bundle: nil)
                let controller = storyboard.instantiateViewControllerWithIdentifier("SwipeVC")
                self.presentViewController(controller, animated: true, completion: nil)

            } else {
                // The login failed. Check error to see why.
            }
        }


    }

    @IBAction func onForgotButtonTapped(sender: UIButton) {

        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Reset Password", message: "Please enter your email address", preferredStyle: .Alert)

        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff


        }
        actionSheetController.addAction(cancelAction)

        //Add a text field
        actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
            //TextField configuration
            textField.textColor = UIColor(red: 0/255, green: 201/255, blue: 132/255, alpha: 1)
            textField.placeholder = "Email"
            self.inputTextField = textField;

        }

        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Reset", style: .Destructive) { action -> Void in
            //Do some other stuff

           PFUser.requestPasswordResetForEmailInBackground((self.inputTextField?.text!)!)



        }

        actionSheetController.addAction(nextAction)


        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        


    }

    @IBAction func onSignUpButtonTapped(sender: UIButton) {

        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("SignUpVC")
        self.presentViewController(controller, animated: true, completion: nil)




    }

}
