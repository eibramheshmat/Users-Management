//
//  users.swift
//  Users Management
//
//  Created by IBRAM on 3/21/19.
//  Copyright © 2019 IBRAM. All rights reserved.
//

import UIKit
import CoreData
class users: UIViewController , UITableViewDelegate , UITableViewDataSource{
    //we get all users from database and display all in table view
    @IBOutlet weak var tableViewUsers: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var users : [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewUsers.layer.cornerRadius = 10.0
        tableViewUsers.clipsToBounds = true
        isFetch() // to fill users array with data from database
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            users = try context.fetch(User.fetchRequest())
        }catch{
            print(error)
        }
        let cell = tableViewUsers.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! mycell
        cell.userImage.image = UIImage(named: "usernamecardicon")
        cell.userName.text = users[indexPath.row].userName
        cell.userEmail.text = users[indexPath.row].userEmail
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "userdetails", sender: users[indexPath.row])
    }
    //for send value to user details view
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        if let dis = segue.destination as? userDetails {
            if let user = sender as? User {
                dis.userSelect = user
            }
        }
    }
    //for fill data in users array
    func isFetch() {
        do {
            users = try context.fetch(User.fetchRequest())
        }catch{
            print(error)
        }
    }
}
