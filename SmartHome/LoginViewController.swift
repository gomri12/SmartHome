//
//  ViewController.swift
//  SmartHome
//
//  Created by omri ios on 6/17/16.
//  Copyright © 2016 omri ios. All rights reserved.
//

import UIKit
import Alamofire
import Firebase


class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        navigationItem.hidesBackButton = true
        
    }

    @IBOutlet weak var usernameTB: UITextField!
    
    @IBOutlet weak var passwordTB: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginBTN(sender: AnyObject) {
        FIRAuth.auth()?.createUserWithEmail(usernameTB.text!, password: passwordTB.text!, completion: {
            user, error in
            if error != nil{
                self.login();
            }
            else{
                print("user created")
                self.login();
            }
        })
    }
    
    func login(){
        FIRAuth.auth()?.signInWithEmail(usernameTB.text!, password: passwordTB.text!, completion: {
            user, error in
            
            if error != nil{
                print("something wrong")
            }
            else{
                print("user is logged")
            }
        })
    }

}

