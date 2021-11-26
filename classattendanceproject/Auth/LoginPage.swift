//
//  LoginPage.swift
//  classattendanceproject
//
//  Created by Parisut Supchokpool on 22/10/2564 BE.
//

import UIKit
import Firebase

class LoginPage: UIViewController {
    
    @IBOutlet weak var logintextlable: UILabel!
    @IBOutlet weak var email: CustomTextField!
    @IBOutlet weak var emailtextlable: UILabel!
    @IBOutlet weak var password: CustomTextField!
    @IBOutlet weak var registerbtn: UIButton!
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var loginbtnlable: UIButton!
    @IBOutlet weak var passwordtextlable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginbtnlable.titleLabel!.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        lable.font = UIFont(name: Constants.ConstantFont.Thin, size: 18)
        logintextlable.font = UIFont(name: Constants.ConstantFont.BOLD, size: 28)
        emailtextlable.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        registerbtn.titleLabel!.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        passwordtextlable.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
    }
    
    
    @IBAction func onTapLogin(_ sender: Any) {

        let email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
//        // Signing in the user
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//            if error != nil {
//                print("Login Fail")
//            }
//            else {
//                print("Login Success!")
//                let homeViewController = self.storyboard?.instantiateViewController(identifier: "home")
//                self.view.window?.rootViewController = homeViewController
//                self.view.window?.makeKeyAndVisible()
//            }
//        }
        DatabaseManager.shared.login(email: email, password: password) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    DatabaseManager.shared.saveType(type: user.usertype!)
                    DatabaseManager.shared.saveUserID(type: user.usernumber!)
                    print("USER",user)
                    let homeViewController = self?.storyboard?.instantiateViewController(identifier: "home")
                    self?.view.window?.rootViewController = homeViewController
                    self?.view.window?.makeKeyAndVisible()
                case .failure(let error):
                    print("ERROR",error) //.localizedDescription
                }
            }
        }

    }
    
    @IBAction func registerBtn(_ sender: Any) {
        let registerController = self.storyboard?.instantiateViewController(identifier: "choosetype") as? ChooseType
        self.view.window?.rootViewController = registerController
        self.view.window?.makeKeyAndVisible()
    }
    
}
