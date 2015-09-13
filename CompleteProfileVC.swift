//
//  CompleteProfileVC.swift
//  Platonic
//
//  Created by Ronald Hernandez on 9/11/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

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

        let urlArray = ["http://static.comicvine.com/uploads/original/11111/111113908/3006275-cyclops_dialogue_3.png", "http://cscdn.marvelheroes.com/costume/en/Store_Rogue_Savagelands.png", "http://www.geekoutpost.com/wp-content/uploads/2015/07/storm_feature.jpg", "http://static.comicvine.com/uploads/original/11113/111130700/3535916-8192069448-wolve.jpg"]


        let user:PFUser = PFUser()

        var counter = 1

        for url in urlArray{

            let nsurl = NSURL(string: url)

            if let data = NSData(contentsOfURL: nsurl!){

                self.profileImage.image = UIImage(data: data)

                let imageFile:PFFile = PFFile(data: data)


                user["profileImage"] = imageFile
                user["gender"] = "Female"
                user["lgbtOnly"] = false
                user["username"] = "user\(counter)"

                counter++

                user.signUp()
            }

            
            
        }
        
        








        // Do any additional setup after loading the view.
        self.imagePicker.delegate = self

        //getting information from a user from facebook is called a GRAPH Request

        let graphRequest: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender"])

        graphRequest.startWithCompletionHandler {

            (connection, result, error) -> Void in

            //do simple check

            if error != nil {
                print(error)
            } else if let result = result {

                User.currentUser()?["name"] = result["name"]
                User.currentUser()?.save()

                let userId = result["id"] as! String

                let facebookProfilePictureURL = "http://graph.facebook.com/" + userId + "/picture?type=large"

                if let fbPicURl = NSURL(string: facebookProfilePictureURL){

                    if let data = NSData(contentsOfURL: fbPicURl){

                        self.profileImage.image = UIImage(data: data)

                        let imageFile:PFFile = PFFile(data: data)

                        User.currentUser()!["profileImage"] = imageFile

                        User.currentUser()?.save()
                    }


                }
            }
        }

    }


    @IBAction func onNextButtonTapped(sender: AnyObject) {

        // User.currentUser()?.profileImage = nil
        if self.genderSelector.selectedSegmentIndex == 0 {
            User.currentUser()?["gender"] = "Male"
        }else{
            User.currentUser()?["gender"] = "Female"
        }

        if self.lgbtFilter.selectedSegmentIndex == 0 {

            User.currentUser()?["lgbtOnly"] = true
        }else{
            User.currentUser()?["lgbtOnly"] = false
        }

        User.currentUser()?["school"] = self.schoolTextField.text!
        User.currentUser()?["job"] = self.jobTextField.text!
        User.currentUser()?["personality"] = self.presonalityTextField.text!


        User.currentUser()?.save()

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
