//
//  InviteClass.swift
//  classattendanceproject
//
//  Created by Parisut Supchokpool on 23/11/2564 BE.
//

import UIKit

class InviteClass: UIViewController {


    
    @IBOutlet weak var showInviteCode: CustomTextField!
    @IBOutlet weak var TitleLable: UILabel!
    @IBOutlet weak var HeaderLable: UILabel!

    @IBAction func back(_ sender: Any) {
        DatabaseManager.shared.removeInvite()
        let home = self.storyboard?.instantiateViewController(identifier: "home")
        self.view.window?.rootViewController = home
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseManager.shared.updateDocID()
        showInviteCode.text = DatabaseManager.shared.checkInvite()
        HeaderLable.font = UIFont(name: Constants.ConstantFont.Medium, size: 24)
        TitleLable.font = UIFont(name: Constants.ConstantFont.BOLD, size: 22)
        showInviteCode.font = UIFont(name: Constants.ConstantFont.BOLD, size: 22)
        CreateBackHome.titleLabel?.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        InviteTextLable.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        SubjectIDLable.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        SubjectNameLable.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var CreateBackHome: UIButton!
    @IBOutlet weak var InviteTextLable: UILabel!
    @IBOutlet weak var SubjectIDLable: UILabel!
    @IBOutlet weak var SubjectNameLable: UILabel!
    
    
    
    
    
    //textfield
    @IBOutlet weak var SubID: CustomTextField!
    
    @IBOutlet weak var SubName: CustomTextField!
    
}
