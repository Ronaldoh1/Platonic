//
//  CompleteProfile.swift
//  Platonic
//
//  Created by Ronald Hernandez on 9/11/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class CompleteProfile: UIViewController {

    @IBOutlet var aboutMe: [UITextView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onNextButtonTapped(sender: UIBarButtonItem) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
