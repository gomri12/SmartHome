//
//  Device.swift
//  SmartHome
//
//  Created by Noyloy on 6/21/16.
//  Copyright © 2016 omri ios. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

public class Device {
    // device info
    var url = "214.265.14.1/webservicelocation.asmx"
    var name = "Device"
    var isOn:String
    
    var centerCoord:CLLocationCoordinate2D?
    var radiosTrigger:CLLocationDistance?
    var geoFence:CLCircularRegion?
    
    // device ui info
    var icon:UIImage
    
    init(url: String,name:String,icon:UIImage){
        self.url = url
        self.name = name
        self.icon = icon
        self.isOn = "false"
    }
    
    func setRule(centerCoord:CLLocationCoordinate2D,radiosTrigger:CLLocationDistance){
        self.centerCoord = centerCoord
        self.radiosTrigger = radiosTrigger
        self.geoFence = CLCircularRegion(center: centerCoord, radius: radiosTrigger, identifier:name)
        self.geoFence?.notifyOnEntry = true
    }

}