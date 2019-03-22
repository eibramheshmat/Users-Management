//
//  forgetPassword.swift
//  Users Management
//
//  Created by IBRAM on 3/21/19.
//  Copyright © 2019 IBRAM. All rights reserved.
//

import UIKit

class forgetPassword: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var designBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //for design textfield
        emailText.borderStyle = .none
        emailText.layer.cornerRadius = 10.0
        emailText.clipsToBounds = true
        designBtn.layer.cornerRadius = 10.0
        designBtn.clipsToBounds = true
    }
    
    @IBAction func sendBtn(_ sender: UIButton) {
        //code for forget password ..
        shouldPerformSegue(withIdentifier: "home", sender: nil)
    }
}
