//
//  DeviceListTableViewController.swift
//  SmartHome
//
//  Created by Noyloy on 6/20/16.
//  Copyright © 2016 omri ios. All rights reserved.
//
import Foundation
import UIKit

class DeviceListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    // MARK: Properties
    @IBOutlet var deviceTableView: UITableView!
    var items: [String] = ["We", "Heart", "Swift"]
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:DeviceTableCell = self.deviceTableView.dequeueReusableCellWithIdentifier("cell") as! DeviceTableCell
        
        cell.deviceLabel.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}
