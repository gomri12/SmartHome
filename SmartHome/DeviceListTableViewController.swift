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

class DeviceListTableViewController:  UITableViewController{
    // MARK: Properties
    @IBOutlet var deviceTableView: UITableView!
    let ref = FIRDatabase.database().reference()
    let user = FIRAuth.auth()?.currentUser
    var deleteDeviceIndexPath: NSIndexPath? = nil
    var items: [Device] = []
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelectionDuringEditing = false
    }
    
    override func viewDidAppear(animated: Bool) {
        let userRef = ref.child((user?.uid)!)
        
        userRef.observeEventType(.Value) { (snap: FIRDataSnapshot) in
            var newItems = [Device]()
            
            for item in snap.children{
                let device = Device(snapshot: item as! FIRDataSnapshot)
                newItems.append(device)
            }
            self.items = newItems
            self.tableView.reloadData()
        }
    }
    
    
    
    @IBAction func logoutBTN(sender: AnyObject) {
        
        self.performSegueWithIdentifier("login", sender: nil)
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    @IBAction func addDeviceBTN(sender: AnyObject) {
        
        // Alert View for input
        let alert = UIAlertController(title: "Add Device",
                                      message: nil,
                                      preferredStyle: .Alert)
        
        let addAction = UIAlertAction(title: "Add",style: .Default) { (action: UIAlertAction!) -> Void in
            
            
            let name = alert.textFields![0]
            let url = alert.textFields![1]
            
            let deviceItem = Device(url: url.text! ,name: name.text!, imageName: "Image")
            
            
            let deviceItemRef = self.ref.child((self.user?.uid)!).child(deviceItem.uniqueID)
            
            
            deviceItemRef.setValue(deviceItem.toAnyObject())
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "Device Name"
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "Device URL"
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
                              animated: true,
                              completion: nil)
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:DeviceTableCell = self.deviceTableView.dequeueReusableCellWithIdentifier("cell") as! DeviceTableCell
        
        cell.deviceLabel.text = self.items[indexPath.row].name
        cell.deviceImage.image = self.items[indexPath.row].icon
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print("You selected cell #\(indexPath.row)!")
        
    }
    
    //alert to check if user wants to delete device
    func confirmDelete(device: Device) {
        let alert = UIAlertController(title: "Delete Device", message: "Are you sure you want to permanently delete \(device.name)?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeleteDevice)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: handleCancelDevice)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func handleDeleteDevice(alertAction: UIAlertAction!) -> Void {
        // 1
        print("Delete was pressed")
        let userRef = ref.child((user?.uid)!)
        let deleteDevice = items[(deleteDeviceIndexPath?.row)!]
        let deviceRef = userRef.child(deleteDevice.uniqueID)
        
        deviceRef.removeValue()
    }
    func handleCancelDevice(alertAction: UIAlertAction!) -> Void {
        deleteDeviceIndexPath = nil
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            deleteDeviceIndexPath = indexPath
            let deviceToDelete = items[indexPath.row]
            confirmDelete(deviceToDelete)
        }
    }}
