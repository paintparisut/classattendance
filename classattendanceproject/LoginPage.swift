//
//  LoginPage.swift
//  classattendanceproject
//
//  Created by Parisut Supchokpool on 22/10/2564 BE.
//

import UIKit
import Firebase

class LoginPage: UIViewController {
    
    @IBOutlet weak var email: CustomTextField!
    
    @IBOutlet weak var password: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func loginTapped(_ sender: Any) {
        // Create cleaned versions of the text field
        let email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                //Couldn't sign in
                print("Login Fail")
            }
            else {
                
                print("Login Success!")
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
