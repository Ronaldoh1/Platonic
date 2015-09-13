//
//  User.swift
//  Platonic
//
//  Created by Ronald Hernandez on 9/11/15.
//  Copyright © 2015 Parse. All rights reserved.
//



class User : PFUser  {

     @NSManaged var address: String
    @NSManaged var profileImage: PFFile
    @NSManaged var job : String
    @NSManaged var school: String
    @NSManaged var personality: String
    @NSManaged var about : String
    @NSManaged var gender : String
    @NSManaged var lgbtFriendsOnly : Bool




    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }

}
