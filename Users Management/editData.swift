//
//  editData.swift
//  Users Management
//
//  Created by IBRAM on 3/22/19.
//  Copyright © 2019 IBRAM. All rights reserved.
//

import UIKit

class editData: UIViewController , UITextFieldDelegate {
    
    var usernamefromprofile :String? // we get user name from profile view
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var fristnameText: UITextField!
    @IBOutlet weak var lastnameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var cpasswordText: UITextField!
    @IBOutlet weak var btnDesign: UIButton!
    @IBOutlet weak var mainView: UIView!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        //for design textfields
        cpasswordText.delegate = self
        passwordText.delegate = self
        emailText.delegate = self
        usernameText.borderStyle = .none
        fristnameText.borderStyle = .none
        lastnameText.borderStyle = .none
        ageText.borderStyle = .none
        emailText.borderStyle = .none
        passwordText.borderStyle = .none
        cpasswordText.borderStyle = .none
        usernameText.layer.cornerRadius = 10.0
        usernameText.clipsToBounds = true
        fristnameText.layer.cornerRadius = 10.0
        fristnameText.clipsToBounds = true
        lastnameText.layer.cornerRadius = 10.0
        lastnameText.clipsToBounds = true
        ageText.layer.cornerRadius = 10.0
        ageText.clipsToBounds = true
        emailText.layer.cornerRadius = 10.0
        emailText.clipsToBounds = true
        passwordText.layer.cornerRadius = 10.0
        passwordText.clipsToBounds = true
        cpasswordText.layer.cornerRadius = 10.0
        cpasswordText.clipsToBounds = true
        btnDesign.layer.cornerRadius = 10.0
        btnDesign.clipsToBounds = true
        let imgsideforusername = UIImage(named: "usernamecardicon")
        textIcon(textField: usernameText, img: imgsideforusername!)
        let imgsideforfirstname = UIImage(named: "nameicon")
        textIcon(textField: fristnameText, img: imgsideforfirstname!)
        let imgsideforlastname = UIImage(named: "nameicon")
        textIcon(textField: lastnameText, img: imgsideforlastname!)
        let imgsideforage = UIImage(named: "ageicon")
        textIcon(textField: ageText, img: imgsideforage!)
        let imgsideforemail = UIImage(named: "emailicon")
        textIcon(textField: emailText, img: imgsideforemail!)
        let imgsideforpass = UIImage(named: "passwordicon")
        textIcon(textField: passwordText, img: imgsideforpass!)
        let imgsideforcpass = UIImage(named: "passwordicon")
        textIcon(textField: cpasswordText, img: imgsideforcpass!)
        fillAllData()// fill text field with data from database
    }
    // design textfields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (textField == cpasswordText ){
            
            scrollView.setContentOffset(CGPoint.init(x: 0, y: 125), animated: true)
        }
        else if (textField == passwordText ){
            
            scrollView.setContentOffset(CGPoint.init(x: 0, y: 125), animated: true)
        }
        else if (textField == emailText ){
            
            scrollView.setContentOffset(CGPoint.init(x: 0, y: 125), animated: true)
        }
        else {
            print("All Done")
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
    func textIcon(textField : UITextField , img : UIImage)  {
        let leftImg = UIImageView( frame: CGRect(x: 0.0, y: 0.0, width: 30 , height: 30))
        leftImg.image = img
        textField.leftView = leftImg
        textField.leftViewMode = .always
    }
    @IBAction func editBtn(_ sender: UIButton) {
        // we search about user name in database when find it update all data about this user name
        if usernameText.text?.isEmpty == false && fristnameText.text?.isEmpty == false && lastnameText.text?.isEmpty == false && ageText.text?.isEmpty == false && emailText.text?.isEmpty == false && passwordText.text?.isEmpty == false && cpasswordText.text?.isEmpty == false && cpasswordText.text == passwordText.text && isValidEmail(testStr: emailText.text!) == true && isValidUsername(testStr: usernameText.text!) == true {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            var users : [User] = []
            do {
                users = try context.fetch(User.fetchRequest())
            }catch{
                print(error)
            }
            let userNa = usernamefromprofile
            for index in 0..<users.count{
                let user = users[index]
                let namefromdb = user.userName
                if userNa == namefromdb {
                    let objecUpdate = user
                    objecUpdate.setValue(usernameText.text, forKey: "userName")
                    objecUpdate.setValue(fristnameText.text, forKey: "fristName")
                    objecUpdate.setValue(lastnameText.text, forKey: "lastName")
                    objecUpdate.setValue(ageText.text, forKey: "userAge")
                    objecUpdate.setValue(emailText.text, forKey: "userEmail")
                    objecUpdate.setValue(passwordText.text, forKey: "userPassword")
                    do {
                        try context.save()
                        profile.globalVar.userName = usernameText.text! // for make session id with new updated value
                        let alert = UIAlertController(title: "Editing", message: " Edit Done ", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                            let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "goRegist")
                            self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
                        }
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }catch{
                        print(error)
                    }
                    break
                }
                else
                {
                    print("Not Found User In Data")
                }
            }
        }else {
            let alert = UIAlertController(title: "Error", message: " Enter valid data ..! ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    @IBAction func closeBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // eamil & username validation like register view
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func isValidUsername(testStr:String) -> Bool{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var users : [User] = []
        do {
            users = try context.fetch(User.fetchRequest())
        }catch{
            print(error)
        }
        let userN = testStr
        for index in 0..<users.count{
            let user = users[index]
            let namefromdb = user.userName
            if userN == namefromdb  {
                return false
            }
        }
        return true
    }
    // fill text field with data from database
    func fillAllData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var users : [User] = []
        do {
            users = try context.fetch(User.fetchRequest())
        }catch{
            print(error)
        }
        let userNa = usernamefromprofile
        for index in 0..<users.count{
            let user = users[index]
            let namefromdb = user.userName
            if userNa == namefromdb {
                usernameText.text = user.userName
                fristnameText.text = user.fristName
                lastnameText.text = user.lastName
                ageText.text = user.userAge
                emailText.text = user.userEmail
                break
            }
            else
            {
                print("Error")
            }
        }
    }
}
