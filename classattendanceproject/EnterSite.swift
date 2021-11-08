//
//  EnterSite.swift
//  classattendanceproject
//
//  Created by TAPE on 3/11/2564 BE.
//

import UIKit

class EnterSite: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headertext.font = UIFont(name: Constants.ConstantFont.BOLD, size: 28)
        
        loginbtntext.titleLabel!.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        
        registerbtntext.titleLabel!.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        
        headertext.textColor = UIColor(cgColor: Constants.GraphicColors.COSCI_BLUEPMR_COLOR)
        
        registerbtntext.titleLabel!.textColor = UIColor(cgColor: Constants.GraphicColors.COSCI_BLUEPMR_COLOR)
        
        loginbtntext.titleLabel!.textColor = UIColor.white

    }
    
    @IBAction func Login(_ sender: Any) {
        let LoginViewController = self.storyboard?.instantiateViewController(identifier: "gotologin") as? LoginPage
        self.view.window?.rootViewController = LoginViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBOutlet weak var headertext: UILabel!
    @IBOutlet weak var loginbtntext: UIButton!
    @IBOutlet weak var registerbtntext: UIButton!
    @IBAction func Register(_ sender: Any) {
        let ChooseTypeViewController = self.storyboard?.instantiateViewController(identifier: "choosetype") as? ChooseType
        self.view.window?.rootViewController = ChooseTypeViewController
        self.view.window?.makeKeyAndVisible()
    }
}
