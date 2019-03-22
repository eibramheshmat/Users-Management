//
//  login.swift
//  Users Management
//
//  Created by IBRAM on 3/20/19.
//  Copyright © 2019 IBRAM. All rights reserved.
//

import UIKit
import CoreData
class login: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var btnDesign: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //for design textfield
        emailText.borderStyle = .none
        passwordText.borderStyle = .none
        emailText.layer.cornerRadius = 10.0
        emailText.clipsToBounds = true
        passwordText.layer.cornerRadius = 10.0
        passwordText.clipsToBounds = true
        btnDesign.layer.cornerRadius = 10.0
        btnDesign.clipsToBounds = true
        let imgsideforemail = UIImage(named: "emailicon")
        textIcon(textField: emailText, img: imgsideforemail!)
        let imgsideforpass = UIImage(named: "passwordicon")
        textIcon(textField: passwordText, img: imgsideforpass!)
    }
    
    
    
    
    @IBAction func loginBtn(_ sender: UIButton) {
        //retrieve all user and search about user in textfields
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var users : [User] = []
        do {
            users = try context.fetch(User.fetchRequest())
        }catch{
            print(error)
        }
        var x=0 // for check if login or not
        let userN = emailText.text
        let passin = passwordText.text
        for index in 0..<users.count{
            let user = users[index]
            let namefromdb = user.userName
            let passfromdb = user.userPassword
            if userN == namefromdb && passin == passfromdb {
                profile.globalVar.userName = user.userName!
                shouldPerformSegue(withIdentifier: "homefromlogin", sender: nil)
                x = 1
                break
            }
        }
        if x == 1{
            print("done")
        }else{
            let alert = UIAlertController(title: "Error", message: " Try again ..! ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
    }
    // for design textfield
    func textIcon(textField : UITextField , img : UIImage)  {
        let leftImg = UIImageView( frame: CGRect(x: 0.0, y: 0.0, width: 30 , height: 30))
        leftImg.image = img
        textField.leftView = leftImg
        textField.leftViewMode = .always
    }
    @IBAction func closeBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)  
        dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
