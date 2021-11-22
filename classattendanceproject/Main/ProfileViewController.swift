//
//  ProfileViewController.swift
//  classattendanceproject
//
//  Created by Parisut Supchokpool on 12/11/2564 BE.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var tfemail: UITextField!
    @IBOutlet weak var tfname: UITextField!
    @IBOutlet weak var tfnumber: UITextField!
    @IBOutlet weak var tftype: UITextField!
    @IBOutlet weak var headerlable: UILabel!
    
    
    @IBAction func logoutbtn(_ sender: Any) {
        DatabaseManager.shared.logout()
        let Entersite = self.storyboard?.instantiateViewController(identifier: "entersite") as? EnterSite
        self.view.window?.rootViewController = Entersite
    }
    
    
    @IBAction func backbtn(_ sender: Any) {
        let home = self.storyboard?.instantiateViewController(identifier: "home") as? HomeViewController
        self.view.window?.rootViewController = home
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseManager.shared.getdata(data:"user_email",get: tfemail)
        DatabaseManager.shared.getdata(data:"user_name",get: tfname)
        DatabaseManager.shared.getdata(data:"user_number",get: tfnumber)
        DatabaseManager.shared.getdata(data:"user_type",get: tftype)
        emaillable.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        namelable.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        stdIDlable.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        usertypelable.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        logoutbtntext.tintColor = UIColor(cgColor: Constants.GraphicColors.COSCI_ERROR_COLOR)
        headerlable.font = UIFont(name: Constants.ConstantFont.Medium, size: 28)
        headerlable.textColor = UIColor.white
        logoutbtntext.titleLabel?.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var emaillable: UILabel!
    @IBOutlet weak var namelable: UILabel!
    @IBOutlet weak var stdIDlable: UILabel!
    @IBOutlet weak var usertypelable: UILabel!
    @IBOutlet weak var logoutbtntext: UIButton!
    
}
