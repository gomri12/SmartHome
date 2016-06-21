//
//  Device.swift
//  SmartHome
//
//  Created by Noyloy on 6/21/16.
//  Copyright © 2016 omri ios. All rights reserved.
//

import Foundation
import UIKit

public class Device {
    // device info
    var location = "214.265.14.1/webservicelocation.asmx"
    var name = "Device"
    
    // device ui info
    var icon:UIImage
    
    init(location: String,name:String,icon:UIImage){
        self.location = location
        self.name = name
        self.icon = icon
        
    }
}