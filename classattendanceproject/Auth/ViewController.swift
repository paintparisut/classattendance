//
//  ViewController.swift
//  classattendanceproject
//
//  Created by Parisut Supchokpool on 15/10/2564 BE.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tffullname: CustomTextField!
    @IBOutlet weak var tfemail: UITextField!
    @IBOutlet weak var tfpassword: UITextField!
    @IBOutlet weak var tfconfirmpass: UITextField!
    @IBOutlet weak var tfstudentnum: UITextField!
    
    func CheckGuard() -> Bool {
        if tffullname.text == "" || tfstudentnum.text == "" {
            return false
        }
        return true
    }
    
    var userType:String = ""
    @IBAction func onTapRegister(_ sender: Any) {
        guard  CheckGuard() else {
            let alert = UIAlertController(title: "Error", message: "กรอกข้อมูลให้ครบถ้วน", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        DatabaseManager.shared.register(name: tffullname.text ?? "", email: tfemail.text ?? "", password: tfpassword.text ?? "", usernumber: tfstudentnum.text ?? "" ,type: userType){ [weak self] (result) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let user):
                    print("USER",user)
                    let home = self?.storyboard?.instantiateViewController(identifier: "home")
                    self?.view.window?.rootViewController = home
                case .failure(let error):
                    print("ERROR",error) //.localizedDescription
                    if self?.tfpassword.text?.count ?? 0 < 6 {
                        let alert = UIAlertController(title: "Error", message: "Password ต้องมีมากกว่า 6 ตัว", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                        self?.tfpassword.text! = ""
                        self?.tfconfirmpass.text! = ""
                    }
                    if self?.tfpassword.text != self?.tfconfirmpass.text {
                        let alert = UIAlertController(title: "Error", message: "รหัสผ่านไม่ตรงกัน", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                        self?.tfpassword.text! = ""
                        self?.tfconfirmpass.text! = ""
                    }
                    if ((self?.tfemail.text?.isEmpty) != nil) {
                        let alert = UIAlertController(title: "Error", message: "รูปแบบ Email ไม่ถูกต้อง", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                        self?.tfemail.text = ""
                    }
                    else if ((self?.validate(YourEMailAddress: self?.tfemail.text ?? "")) != nil) {
                        print("2")
                    }
                }
            }
        }
        savedata(type: userType, id: tfstudentnum.text ?? "")
    }
    
    func validate(YourEMailAddress: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourEMailAddress)
    }
    
    func savedata(type:String,id:String) {
        DatabaseManager.shared.saveUserID(type: id)
        DatabaseManager.shared.saveType(type: type)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registertextlable.font = UIFont(name: Constants.ConstantFont.BOLD, size: 28)
        emailtextlable.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        studentIDtextlable.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        nametextlable.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        passwordtextlable.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        cfpasswordtextlable.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        registerbtntext.titleLabel!.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        registerbtnlable.titleLabel!.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        lable.font = UIFont(name: Constants.ConstantFont.Thin, size: 18)
        print("regis",userType)
        
    }
    
    
    @IBAction func registerbtn(_ sender: Any) {
        let loginController = self.storyboard?.instantiateViewController(identifier: "gotologin") as? LoginPage
        self.view.window?.rootViewController = loginController
        self.view.window?.makeKeyAndVisible()
        
    }
    
    @IBOutlet weak var registerbtnlable: UIButton!
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var registertextlable: UILabel!
    @IBOutlet weak var emailtextlable: UILabel!
    @IBOutlet weak var studentIDtextlable: UILabel!
    @IBOutlet weak var nametextlable: UILabel!
    @IBOutlet weak var passwordtextlable: UILabel!
    @IBOutlet weak var cfpasswordtextlable: UILabel!
    @IBOutlet weak var registerbtntext: UIButton!

    
}

