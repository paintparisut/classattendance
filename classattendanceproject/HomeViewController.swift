//
//  HomeViewController.swift
//  classattendanceproject
//
//  Created by Parisut Supchokpool on 1/11/2564 BE.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDataSource,UITableViewDelegate  {
//    @IBOutlet weak var headerlable: UILabel!
    
    @IBOutlet weak var headerlable: UILabel!
    
    var subjectname:[String] = ["Object Oriented Programming","Database Management System","Consumer Behavior","Active Citizens"]
    var subjectid:[String] = ["CSC261","CSC251","COS302","SWU261"]
    var subjecttime:[String] = ["9:00-11.30","9:00-11:30","9:00-11:30","9:00-11:30"]
    var stdcount:[String] = ["45","45","45","45"]
    var checkstats:[String] = ["0","1","0","2"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectname.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectcard", for: indexPath) as! SubjectCardCell
        cell.subject(id: subjectid[indexPath.row], name: subjectname[indexPath.row], time: subjecttime[indexPath.row], stdcount: stdcount[indexPath.row], checkstat: checkstats[indexPath.row])
        
        return cell
    }
    

    @IBAction func profileButton(_ sender: Any) {
        let Profile = self.storyboard?.instantiateViewController(identifier: "profile") as? ProfileViewController
        self.view.window?.rootViewController = Profile
        //self.view.window?.makeKeyAndVisible()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        headerlable.font = UIFont(name: Constants.ConstantFont.Medium, size: 28)
        headerlable.textColor = UIColor.white
//        headerlable.font = UIFont(name: Constants.ConstantFont.BOLD, size: 28)
//        headerlable.textColor = UIColor(cgColor: Constants.GraphicColors.COSCI_BLUEPMR_COLOR)
    }

}
