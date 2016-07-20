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
    let devicesDic : [String: String] = ["Speakers":"Image-1","A/C" : "Image-2","Washing Machine": "Image-3","Television": "Image-4","Refrigerator":"Image-5","Lamp": "Image"	]
    let devicesNames = ["Speakers","A/C" ,"Washing Machine","Television","Refrigerator","Lamp"]
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
        
        self.performSegueWithIdentifier("addDevice", sender: nil)
        
    }	
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:DeviceTableCell = self.deviceTableView.dequeueReusableCellWithIdentifier("cell") as! DeviceTableCell
        
        cell.deviceLabel.text = self.items[indexPath.row].name
        cell.deviceImage.image = self.items[indexPath.row].icon
        cell.deviceSwitch.tag = indexPath.row
        cell.deviceSwitch.addTarget(self, action: #selector(DeviceListTableViewController.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged )
        return cell
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            print("Switch on row ",switchState.tag,": is On")
            items[switchState.tag].turnSwitch(true,id: String(switchState.tag+1))
        }else{
            print("Switch on row ",switchState.tag,": is OFF")
            items[switchState.tag].turnSwitch(false,id: String(switchState.tag+1))
        }
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
