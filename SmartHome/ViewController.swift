//
//  ViewController.swift
//  SmartHome
//
//  Created by omri ios on 6/17/16.
//  Copyright © 2016 omri ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var usernameTB: UITextField!
    
    @IBOutlet weak var passwordTB: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginBTN(sender: AnyObject) {
    }

}

