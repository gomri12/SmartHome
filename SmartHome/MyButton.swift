//
//  MyButton.swift
//  SmartHome
//
//  Created by omri ios on 6/17/16.
//  Copyright © 2016 omri ios. All rights reserved.
//

import Foundation
import UIKit

class MyButton: UIButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0;

        self.layer.borderWidth = 0
        self.backgroundColor = UIColor(red: 22/256, green: 160/256, blue: 134/256, alpha: 1)
        self.tintColor = UIColor.whiteColor()
        
    }
}