//
//  Dog.swift
//  isDogHereApp
//
//  Created by Sina Yeganeh on 30/11/2015.
//  Copyright © 2015 Sina Yeganeh. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct Dog {
    let dogName: String
    let owner: String
    let image: UIImage
    let location: String
    let isHere: Bool?
    let ownerEmail: String
    
    init(dogName: String, owner: String, location: String, base64Image: String, isHere: Bool, ownerEmail: String) {
        self.dogName = dogName
        self.owner = owner
        self.location = location
        let imageData = NSData(base64EncodedString: base64Image, options: .IgnoreUnknownCharacters)
        self.image = UIImage(data: imageData!)!
        self.isHere = isHere
        self.ownerEmail = ownerEmail
    }
    
    init(snapshot: FDataSnapshot) {
        dogName = snapshot.key
        owner = snapshot.value["Owner"] as! String
        isHere = snapshot.value["IsHere"] as? Bool
        let imageData = snapshot.value["ImageURL"] as! String
        // HTTP data, used workaround to NSAppTransportSecurity
        image = UIImage(data: NSData(contentsOfURL: NSURL(string: imageData)!)!)!
        location = snapshot.value["Location"] as! String
        ownerEmail = snapshot.value["OwnerEmail"] as! String
    }
    
}