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



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignInWithFacebookButtonTapped(sender: AnyObject) {






    }
    @IBAction func onSignInWithTwitterButtonTapped(sender: AnyObject) {


    }
    @IBAction func onSignInButtonTapped(sender: AnyObject) {

        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("SignInVC")
        self.presentViewController(controller, animated: true, completion: nil)

        
    }
    @IBAction func onSignUpButtonTapped(sender: AnyObject) {
        var storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("SignUpVC") as! UINavigationController
        self.presentViewController(controller, animated: true, completion: nil)

    }
}

