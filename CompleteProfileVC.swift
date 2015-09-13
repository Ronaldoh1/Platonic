//
//  CompleteProfileVC.swift
//  Platonic
//
//  Created by Ronald Hernandez on 9/11/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class CompleteProfileVC: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var genderSelector: UISegmentedControl!
    @IBOutlet weak var lgbtFilter: UISegmentedControl!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var presonalityTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



    @IBAction func onChooseProfileImageTapped(sender: UIButton) {



    }

}
