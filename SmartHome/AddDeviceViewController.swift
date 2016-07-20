//
//  AddDeviceViewController.swift
//  SmartHome
//
//  Created by omri ios on 7/20/16.
//  Copyright © 2016 omri ios. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddDeviceViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    

    let ref = FIRDatabase.database().reference()
    let user = FIRAuth.auth()?.currentUser
    var itemSelected = 0
    let devicesNames = ["Image-1","Image-2","Image-3","Image-4","Image-5", "Image"]
    
    @IBOutlet weak var deviceNameTB: UITextField!
    @IBOutlet weak var deviceURLTB: UITextField!
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.whiteColor()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        
    }
    
    @IBAction func addBTN(sender: AnyObject) {
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devicesNames.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ImageCell
        
        cell.image.image = UIImage(named: devicesNames[indexPath.row] )
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        <#code#>
    }
    
    
}