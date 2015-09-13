//
//  CompleteProfileVC.swift
//  Platonic
//
//  Created by Ronald Hernandez on 9/11/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class CompleteProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var genderSelector: UISegmentedControl!
    @IBOutlet weak var lgbtFilter: UISegmentedControl!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var presonalityTextField: UITextField!

    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imagePicker.delegate = self
    }


    @IBAction func onNextButtonTapped(sender: AnyObject) {

       // User.currentUser()?.profileImage = nil
        if self.genderSelector.selectedSegmentIndex == 0 {
              User.currentUser()?.gender = "Male"
        }else{
            User.currentUser()?.gender = "Female"
        }

        if self.lgbtFilter.selectedSegmentIndex == 0 {

            
        }

    }

    @IBAction func onChooseProfileImageTapped(sender: UIButton) {

        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary

        presentViewController(imagePicker, animated: true, completion: nil)


    }

    // MARK: - UIImagePickerControllerDelegate Methods

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profileImage.contentMode = .ScaleAspectFit
            self.profileImage.image = pickedImage
        }

        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
