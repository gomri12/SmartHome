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
import Firebase
import Alamofire

public class Device {
    // device info
    var uniqueID:String
    var url = "214.265.14.1/webservicelocation.asmx"
    var name = "Device"
    var isOn:String
    var imageName:String
    var centerCoord:CLLocationCoordinate2D?
    var radiosTrigger:CLLocationDistance?
    var geoFence:CLCircularRegion?
    
    // device ui info
    var icon:UIImage
    
    // if id is nil then this will create new id
    init(url: String,name:String,imageName:String){
        self.uniqueID = NSUUID().UUIDString
        self.url = url
        self.name = name
        self.imageName = imageName
        self.icon = UIImage(named: imageName)!
        self.isOn = "false"
    }
    
    init(snapshot: FIRDataSnapshot){
        self.uniqueID = snapshot.value!["uniqueID"] as! String
        self.url = snapshot.value!["url"] as! String
        self.name = snapshot.value!["name"] as! String
        self.imageName = snapshot.value!["imageName"] as! String
        self.isOn = snapshot.value!["isOn"] as! String
        self.icon = UIImage(named: imageName)!
        
    }
    
    func toAnyObject() -> AnyObject{
        return [
            "uniqueID": uniqueID,
            "url": url,
            "name": name,
            "imageName": imageName,
            "isOn": isOn
        ]
    }
    
    func setRule(centerCoord:CLLocationCoordinate2D,radiosTrigger:CLLocationDistance, switchOffOnExit:Bool){
        self.centerCoord = centerCoord
        self.radiosTrigger = radiosTrigger
        self.geoFence = CLCircularRegion(center: centerCoord, radius: radiosTrigger, identifier:uniqueID)
        self.geoFence?.notifyOnEntry = true
        self.geoFence?.notifyOnExit = switchOffOnExit
    }
    
    func turnSwitch(state: Bool) -> Bool{
        let parameters: [String: AnyObject] = [
            "Id" : "1",
            "Action" : "false"
        ]
        

        Alamofire.request(.GET, "http://site.aplit-soft.com:8080/Services/tmp/index.aspx",parameters: parameters)
            .responseString { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
     return false
    }

}