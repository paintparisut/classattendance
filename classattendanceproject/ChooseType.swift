//
//  ChooseType.swift
//  classattendanceproject
//
//  Created by TAPE on 3/11/2564 BE.
//

import UIKit

class ChooseType: UIViewController {
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var lec: UILabel!
    @IBOutlet weak var student: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.font = UIFont(name: Constants.ConstantFont.BOLD, size: 28)
        student.font = UIFont(name: Constants.ConstantFont.Medium, size: 22)
        lec.font = UIFont(name: Constants.ConstantFont.Medium, size: 22)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "student" {
//            let registerVc = segue.destination as! ViewController
//            registerVc.userType = "student"
//        }
//        else if segue.identifier == "lec" {
//            let registerVc = segue.destination as! ViewController
//            registerVc.userType = "lec"
//        }
//    }
}
