//
//  InviteClass.swift
//  classattendanceproject
//
//  Created by Parisut Supchokpool on 23/11/2564 BE.
//

import UIKit

class InviteClass: UIViewController {

    @IBOutlet weak var showInviteCode: UILabel!
    
    @IBAction func back(_ sender: Any) {
        DatabaseManager.shared.removeInvite()
        let home = self.storyboard?.instantiateViewController(identifier: "home")
        self.view.window?.rootViewController = home
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseManager.shared.updateDocID()
        showInviteCode.text = DatabaseManager.shared.checkInvite()

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
