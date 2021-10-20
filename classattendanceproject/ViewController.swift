//
//  ViewController.swift
//  classattendanceproject
//
//  Created by Parisut Supchokpool on 15/10/2564 BE.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = Constants.GraphicColors.COSCI_BLUEPMR_COLOR
        super.viewDidLoad()
        print("Hello eiei")
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var tffirstname: UITextField!
    @IBOutlet weak var tflastname: UITextField!
    @IBOutlet weak var tfemail: UITextField!
    @IBOutlet weak var tfpassword: UITextField!
    @IBOutlet weak var tfconfirmpass: UITextField!
    @IBOutlet weak var tfstudentnum: UITextField!
    
    @IBAction func onTapRegister(_ sender: Any) {
        DatabaseManager.shared.register(name: "paint", email: tfemail.text ?? "", password: tfpassword.text ?? "", usernumber: "63130010205" ,type:"student"){ [weak self] (result) in
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
}

