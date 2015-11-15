//
//  ViewController.swift
//  GeoLocation
//
//  Created by Daniel Ström on 15/11/15.
//  Copyright © 2015 Daniel Ström. All rights reserved.
//

import UIKit
import ObjectMapper

class ViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    var user:UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.email.text = "b@b.se"
        self.password.text = "qwerty"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mapView" {
            let controller = segue.destinationViewController as! MapController
            controller.user = self.user
        }
    }

    @IBAction func login(sender: UIButton) {
        let model = LoginModel()
        model.email = self.email.text
        model.password = self.password.text
        
        ApiProvider.instance.login(model, callback: {data, error in
            self.user = Mapper<UserModel>().map(data)
            
            if self.user?.success! == true {
                self.performSegueWithIdentifier("mapView", sender: self)
            }
        })
    }

}

