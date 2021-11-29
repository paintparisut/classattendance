//
//  JoinClass.swift
//  classattendanceproject
//
//  Created by TAPE on 28/11/2564 BE.
//

import UIKit

class JoinClass: UIViewController {

    var allclassdata = [ClassModel]()
    
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
        print("check = ",allclassdata)
        HeaderLable.font = UIFont(name: Constants.ConstantFont.Medium, size: 24)
        passclassText.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        titleText.font = UIFont(name: Constants.ConstantFont.BOLD, size: 22)
        tfTextCustom.font = UIFont(name: Constants.ConstantFont.BOLD, size: 22)
        joinBtnText.titleLabel?.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
    }
    
    
    //Join Class
    @IBAction func Join(_ sender: Any) {
        guard DatabaseManager.shared.checkJoinClass(invite: tfTextCustom.text!, classdata: allclassdata) else {
            //ทำalert แจ้งบอกว่าใส่inviteโค้ดผิด
            print("invalid invitecode")
            return
        }
        createClassAttendance()
        DatabaseManager.shared.addStudentList(invite: tfTextCustom.text!, classdata: allclassdata, id: DatabaseManager.shared.checkUserID())
        let home = self.storyboard?.instantiateViewController(identifier: "home")
        self.view.window?.rootViewController = home
    }

    func createClassAttendance() {
        DatabaseManager.shared.createClassAttendance(invite: tfTextCustom.text! , completion: { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let classdata):
                    print("classattendancedata = ",classdata)
                    DatabaseManager.shared.updateDocIDClassAttendance()
                    let vc = self?.storyboard?.instantiateViewController(identifier: "home")
                    self?.view.window?.rootViewController = vc
                    
                case .failure(let error):
                    print("ERROR",error) //.localizedDescription
                }
            }
        })
    }
    
    
}
