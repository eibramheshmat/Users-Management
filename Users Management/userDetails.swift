//
//  userDetails.swift
//  Users Management
//
//  Created by IBRAM on 3/21/19.
//  Copyright © 2019 IBRAM. All rights reserved.
//

import UIKit

class userDetails: UIViewController {
    
    var userSelect : User?
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userFirstname: UILabel!
    @IBOutlet weak var userLastname: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //for design 
        userImg.layer.cornerRadius = 10.0
        userImg.clipsToBounds = true
        userName.layer.cornerRadius = 10.0
        userName.clipsToBounds = true
        userFirstname.layer.cornerRadius = 10.0
        userFirstname.clipsToBounds = true
        userLastname.layer.cornerRadius = 10.0
        userLastname.clipsToBounds = true
        userAge.layer.cornerRadius = 10.0
        userAge.clipsToBounds = true
        userEmail.layer.cornerRadius = 10.0
        userEmail.clipsToBounds = true
        userName.text = " Name : \(userSelect?.userName ?? "name")"
        userFirstname.text = " Frist Name : \(userSelect?.fristName ?? "fname")"
        userLastname.text = " last Name : \(userSelect?.lastName ?? "lname")"
        userAge.text = " Age : \(userSelect?.userAge ?? "age")"
        userEmail.text = " Email : \(userSelect?.userEmail ?? "email")"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
