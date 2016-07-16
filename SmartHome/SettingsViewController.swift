//
//  SettingsViewController.swift
//  SmartHome
//
//  Created by omri ios on 7/15/16.
//  Copyright © 2016 omri ios. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import CoreLocation
import MapKit


class SettingsViewController : UIViewController, CLLocationManagerDelegate{
    
    // noy code start here
    // this class implements CLLocationManagerDelagate
    
    lazy var locationManager: CLLocationManager! = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        return manager
    }()
    
    @IBAction func saveTapped(sender: AnyObject) {
        let devIdx = picker.selectedRowInComponent(0)
        print("add device \(items[devIdx].name) state to list of device rules, fire background updates if needed")
        // TODO:save radios and center location get from ui...
        items[devIdx].setRule(CLLocationCoordinate2D(latitude: 32.4,longitude: 22), radiosTrigger: 34)
        // start monitoring the geofencing state of this device -> in appDelegate
        locationManager.startMonitoringForRegion(items[devIdx].geoFence!)
        //check time sampling
    }
    // noy code ends here
    
    @IBOutlet weak var picker: UIPickerView!

    var items: [Device] = [Device(url: "",name: "Bedroom TV",icon: UIImage(named: "Image")!),
                           Device(url: "",name: "Livingroom TV",icon: UIImage(named: "Image-1")!),
                           Device(url: "",name: "Kitchen TV",icon: UIImage(named: "Image-2")!),
                           Device(url: "",name: "Front Lights",icon: UIImage(named: "Image-3")!),
                           Device(url: "",name: "Bedroom Air Conditioner",icon: UIImage(named: "Image-4")!),
                           Device(url: "",name: "Bedroom Air Conditioner",icon: UIImage(named: "Image-5")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return items[row].name
    }
    
    
    
}