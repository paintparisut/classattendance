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
    
    var userType:String = ""
    
    @IBAction func onTapRegister(_ sender: Any) {
        DatabaseManager.shared.register(name: tffullname.text ?? "", email: tfemail.text ?? "", password: tfpassword.text ?? "", usernumber: tfstudentnum.text ?? "" ,type: userType){ [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("USER",user)
                case .failure(let error):
                    print("ERROR",error) //.localizedDescription
                }
            }
        }
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
        print("regis",userType)
        
    }
    
    @IBOutlet weak var registertextlable: UILabel!
    @IBOutlet weak var emailtextlable: UILabel!
    @IBOutlet weak var studentIDtextlable: UILabel!
    @IBOutlet weak var nametextlable: UILabel!
    @IBOutlet weak var passwordtextlable: UILabel!
    @IBOutlet weak var cfpasswordtextlable: UILabel!
    @IBOutlet weak var registerbtntext: UIButton!

    
}

