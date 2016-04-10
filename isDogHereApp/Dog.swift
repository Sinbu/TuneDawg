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
import Tune

struct Dog {
    let dogName: String
    let owner: String
    let dogID: Int
    let image: UIImage?
    let location: String
    let isHere: Bool?
    let ownerEmail: String
    
    init(dogName: String, dogID: Int, owner: String, location: String, base64Image: String, isHere: Bool, ownerEmail: String, dogSubscriptions: Array<String>) {
        self.dogName = dogName
        self.owner = owner
        self.location = location
        let imageData = NSData(base64EncodedString: base64Image, options: .IgnoreUnknownCharacters)
        self.image = UIImage(data: imageData!)!
        self.isHere = isHere
        self.ownerEmail = ownerEmail
        self.dogID = dogID
    }
    
    init(snapshot: FDataSnapshot) {
        dogName = snapshot.key
        dogID = snapshot.value["ID"] as! Int
        owner = snapshot.value["Owner"] as! String
        isHere = snapshot.value["IsHere"] as? Bool
        let imageData = snapshot.value["ImageURL"] as! String
        location = snapshot.value["Location"] as! String
        ownerEmail = snapshot.value["OwnerEmail"] as! String
        
        // HTTP data, used workaround to NSAppTransportSecurity
        guard let contentOfURL = NSURL(string: imageData) else {
            image = nil
            print("NSURL unable to find resource, setting image to nil")
            return
        }
        guard let data =  NSData(contentsOfURL: contentOfURL) else {
            image = nil
            print("NSData unable to process contentOfURL, setting image to nil")
            return
        }
        guard let imageFromURL = UIImage(data: data) else {
            image = nil
            print("UIImage unable to convert data into image, check the URL. Setting image to nil")
            return
        }
        
        image = imageFromURL
        
    }
    
}