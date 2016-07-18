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


class SettingsViewController : UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var onExitSwitch: UISwitch!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    let ref = FIRDatabase.database().reference()
    let user = FIRAuth.auth()?.currentUser
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func tapGesture(sender: AnyObject) {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        
        let tapLoc = sender.locationInView(self.mapView)
        let locCoord = self.mapView.convertPoint(tapLoc,toCoordinateFromView: self.mapView )
        let devIdx = picker.selectedRowInComponent(0)
        let dpa = DevicePointAnnotation()
        dpa.coordinate = locCoord
        dpa.title = items[devIdx].name
        dpa.imageName = items[devIdx].imageName
        self.mapView.addAnnotation(dpa)
    }
    
    // delegate to show user location in case of user authorized locations updates
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
        centerMapOnLocation(manager.location!)
    }
    
    // noy code start here
    // this class implements CLLocationManagerDelagate
    
    let locationManager = CLLocationManager()
    
    
    @IBAction func saveTapped(sender: AnyObject) {
        let devIdx = picker.selectedRowInComponent(0)
        // TODO:save radios and center location get from ui...
        
        // annotation for coordinate
        let lastAnnotation = self.mapView.annotations[0]
        // text of radius
        var radius = Double(self.radiusTextField.text!)
        if radius==nil {
            radius = 0
        }
        // bool on exit
        let onExit = self.onExitSwitch.on
        
        items[devIdx].setRule(lastAnnotation.coordinate, radiosTrigger: radius!, switchOffOnExit:onExit)
        // start monitoring the geofencing state of this device -> in appDelegate
        locationManager.startMonitoringForRegion(items[devIdx].geoFence!)
        print("device \(items[devIdx].name) id: \(items[devIdx].uniqueID) LatLon=\(items[devIdx].centerCoord) Radius=\(radius) onExit=\(onExit) HAS BEEN added")
        //check time sampling
    }

    @IBAction func forgetBTN(sender: UIButton) {
        stopMonitoringDevice(items[picker.selectedRowInComponent(0)])
    }
    
    func stopMonitoringDevice(device: Device) {
        for region in locationManager.monitoredRegions {
            if let circularRegion = region as? CLCircularRegion {
                if circularRegion.identifier == device.uniqueID {
                    locationManager.stopMonitoringForRegion(circularRegion)
                }
            }
        }
    }
    
    // noy code ends here
    
    @IBOutlet weak var picker: UIPickerView!

    var items: [Device] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        let userRef = ref.child((user?.uid)!)
        
        userRef.observeEventType(.Value) { (snap: FIRDataSnapshot) in
            var newItems = [Device]()
            
            for item in snap.children{
                let device = Device(snapshot: item as! FIRDataSnapshot)
                newItems.append(device)
            }
            self.items = newItems
            
            self.picker.reloadAllComponents()
            
        }
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
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
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is DevicePointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = true
        }
        else {
            anView!.annotation = annotation
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        
        let dpa = annotation as! DevicePointAnnotation
        
        
        // Resize image
        let pinImage = UIImage(named:dpa.imageName)
        let size = CGSize(width: 25, height: 25)
        UIGraphicsBeginImageContext(size)
        pinImage!.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        anView!.image = resizedImage
        
        
        
        return anView
    }
}