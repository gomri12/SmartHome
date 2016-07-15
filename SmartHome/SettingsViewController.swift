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

class SettingsViewController : UIViewController{
    
    @IBOutlet weak var picker: UIPickerView!
    
    var colors = ["SAVTA!!!!!","Noy","Tal"]
    
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
        return colors.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return colors[row]
    }
    
}