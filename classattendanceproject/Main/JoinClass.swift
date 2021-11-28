//
//  JoinClass.swift
//  classattendanceproject
//
//  Created by TAPE on 28/11/2564 BE.
//

import UIKit

class JoinClass: UIViewController {

    @IBAction func back(_ sender: Any) {
        let home = self.storyboard?.instantiateViewController(identifier: "home")
        self.view.window?.rootViewController = home
    }
    @IBOutlet weak var joinBtnText: UIButton!
    @IBOutlet weak var tfTextCustom: CustomTextField!
    @IBOutlet weak var HeaderLable: UILabel!
    @IBOutlet weak var passclassText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        HeaderLable.font = UIFont(name: Constants.ConstantFont.Medium, size: 24)
        passclassText.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        titleText.font = UIFont(name: Constants.ConstantFont.BOLD, size: 22)
        tfTextCustom.font = UIFont(name: Constants.ConstantFont.BOLD, size: 22)
        joinBtnText.titleLabel?.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
    }
    
    
    //Join Class
    @IBAction func Join(_ sender: Any) {
        
        
        
        
        
        
    }

}
