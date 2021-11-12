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
    
    @IBAction func logoutButton(_ sender: Any) {
        DatabaseManager.shared.logout()
        let Entersite = self.storyboard?.instantiateViewController(identifier: "entersite") as? EnterSite
        self.view.window?.rootViewController = Entersite
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseManager.shared.getdata(data:"user_email",get: tfemail)
        DatabaseManager.shared.getdata(data:"user_name",get: tfname)
        DatabaseManager.shared.getdata(data:"user_number",get: tfnumber)
        DatabaseManager.shared.getdata(data:"user_type",get: tftype)

        // Do any additional setup after loading the view.
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
