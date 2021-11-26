//
//  EnterSite.swift
//  classattendanceproject
//
//  Created by TAPE on 3/11/2564 BE.
//

import UIKit
import Firebase

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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DatabaseManager.shared.HomePage = self
        DatabaseManager.shared.showApp()
        print(DatabaseManager.shared.showApp())

        
        if DatabaseManager.shared.showApp() {
            let home = self.storyboard?.instantiateViewController(identifier: "home")
            self.view.window?.rootViewController = home
            self.view.window?.makeKeyAndVisible()
//            self.navigationController?.pushViewController(home!, animated: true)
        }
        

//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        var viewController: UIViewController
//
//        if FirebaseAuth.Auth.auth().currentUser == nil {
//            // User is not signed in.
//            viewController = storyboard.instantiateViewController(withIdentifier: "entersite")
//            print("No user")
//        }
//        else{
//            viewController = storyboard.instantiateViewController(withIdentifier: "home")
//            print("Got user")
//        }
    }
}
