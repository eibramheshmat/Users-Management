//
//  register.swift
//  Users Management
//
//  Created by IBRAM on 3/20/19.
//  Copyright © 2019 IBRAM. All rights reserved.
//

import UIKit
import CoreData
class register: UIViewController , UITextFieldDelegate {
  
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
        //for making textfield left icon
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
        
        // Do any additional setup after loading the view.
    }
    //for design textfields
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
    @IBAction func registBtn(_ sender: UIButton) {
        // we check all data is valid or not and then we insert it
        if usernameText.text?.isEmpty == false && fristnameText.text?.isEmpty == false && lastnameText.text?.isEmpty == false && ageText.text?.isEmpty == false && emailText.text?.isEmpty == false && passwordText.text?.isEmpty == false && cpasswordText.text?.isEmpty == false && cpasswordText.text == passwordText.text && isValidEmail(testStr: emailText.text!) == true && isValidUsername(testStr: usernameText.text!) == true {
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
            newUser.setValue(self.usernameText!.text, forKey: "userName")
            newUser.setValue(self.fristnameText!.text, forKey: "fristName")
            newUser.setValue(self.lastnameText!.text, forKey: "lastName")
            newUser.setValue(self.ageText!.text, forKey: "userAge")
            newUser.setValue(self.emailText!.text, forKey: "userEmail")
            newUser.setValue(self.passwordText!.text, forKey: "userPassword")
            do {
                //for insert and go to home
                try context.save()
                profile.globalVar.userName = usernameText.text!
                let alert = UIAlertController(title: "Registration", message: " Registration Done ", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                    let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "goRegist")
                    self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
            catch
            {
                print(error)
            }
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: " Enter valid data ..! ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    //for design textfields
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
    //email validation
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    //user name validation .. user name should be unique
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
}
