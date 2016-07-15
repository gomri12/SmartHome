//
//  DeviceListTableViewController.swift
//  SmartHome
//
//  Created by Noyloy on 6/20/16.
//  Copyright © 2016 omri ios. All rights reserved.
//
import Foundation
import UIKit
import Firebase

class DeviceListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    // MARK: Properties
    @IBOutlet var deviceTableView: UITableView!

    var items: [Device] = [Device(location: "",name: "Bedroom TV",icon: UIImage(named: "Image")!),
                           Device(location: "",name: "Livingroom TV",icon: UIImage(named: "Image-1")!),
                           Device(location: "",name: "Kitchen TV",icon: UIImage(named: "Image-2")!),
                           Device(location: "",name: "Front Lights",icon: UIImage(named: "Image-3")!),
                           Device(location: "",name: "Bedroom Air Conditioner",icon: UIImage(named: "Image-4")!),
                           Device(location: "",name: "Bedroom Air Conditioner",icon: UIImage(named: "Image-5")!)]
    
    @IBAction func logoutBTN(sender: AnyObject) {
        self.performSegueWithIdentifier("login", sender: nil)
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    @IBAction func addDeviceBTN(sender: AnyObject) {
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:DeviceTableCell = self.deviceTableView.dequeueReusableCellWithIdentifier("cell") as! DeviceTableCell
        
        cell.deviceLabel.text = self.items[indexPath.row].name
        cell.deviceImage.image = self.items[indexPath.row].icon
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}
