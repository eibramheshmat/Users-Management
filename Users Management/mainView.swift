//
//  ViewController.swift
//  Users Management
//
//  Created by IBRAM on 3/20/19.
//  Copyright © 2019 IBRAM. All rights reserved.
//

import UIKit
import CoreData
class mainView: UIViewController {
    //check if there are admin or no .. if no .. create one
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        //create users
        var users : [User] = []
        do {
            users = try context.fetch(User.fetchRequest())
        }catch{
            print(error)
        }
        if users.count == 0 {
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
            newUser.setValue("admin", forKey: "userName")
            newUser.setValue("admin", forKey: "fristName")
            newUser.setValue("admin", forKey: "lastName")
            newUser.setValue("admin", forKey: "userAge")
            newUser.setValue("admin@admin.admin", forKey: "userEmail")
            newUser.setValue("admin", forKey: "userPassword")
            do {
                try context.save()
            }catch{
                print(error)
            }
        }
        else {
            print(" Already admin created")
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}

