//
//  profile.swift
//  Users Management
//
//  Created by IBRAM on 3/21/19.
//  Copyright © 2019 IBRAM. All rights reserved.
//

import UIKit

class profile: UIViewController {
    struct globalVar {
        static var userName = "" // for session id
    }
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var fristName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var logBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // we get user data from database and show it
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var users : [User] = []
        do {
            users = try context.fetch(User.fetchRequest())
        }catch{
            print(error)
        }
        //for design
        imgView.layer.cornerRadius = 10.0
        imgView.clipsToBounds = true
        editBtn.layer.cornerRadius = 10.0
        editBtn.clipsToBounds = true
        logBtn.layer.cornerRadius = 10.0
        logBtn.clipsToBounds = true
        let userNa = globalVar.userName
        for index in 0..<users.count{
            let user = users[index]
            let namefromdb = user.userName
            if userNa == namefromdb {
                userName.text = "User name : \(user.userName ?? "name")"
                fristName.text = " Frist name : \( user.fristName ?? "fname")"
                lastName.text = " Last name : \(user.lastName ?? "lname")"
                age.text = "Age : \(user.userAge ?? "age")"
                email.text = "Email : \(user.userEmail ?? "email")"
                break
            }
        }
    }
    //log out .. go home and make session id " Empty "
    @IBAction func logoutBtn(_ sender: UIButton) {
        profile.globalVar.userName = ""
        shouldPerformSegue(withIdentifier: "logouthome", sender: nil)
    }
    //send data for edit view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is editData
        {
            let vc = segue.destination as? editData
            vc?.usernamefromprofile = profile.globalVar.userName
        }
    }
}
