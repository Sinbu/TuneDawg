//
//  DogTableCell.swift
//  isDogHereApp
//
//  Created by Sina Yeganeh on 01/12/2015.
//  Copyright © 2015 Sina Yeganeh. All rights reserved.
//

import Foundation
import UIKit

class DogTableCell: UITableViewCell {
    
    @IBOutlet weak var dogLocation: UILabel!
    @IBOutlet weak var dogName: UILabel!
    @IBOutlet weak var dogImage: UIImageView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "DogTableCell")
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }

}