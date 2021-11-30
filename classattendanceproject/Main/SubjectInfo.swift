//
//  SubjectInfo.swift
//  classattendanceproject
//
//  Created by TAPE on 14/11/2564 BE.
//

import UIKit

class SubjectInfo: UIViewController {

    @IBOutlet weak var subjectIDLB: UILabel!
    @IBOutlet weak var subjectNameLB: UILabel!
    @IBOutlet weak var subjectTimeLB: UILabel!
    @IBOutlet weak var studentCountLB: UILabel!
    @IBOutlet weak var opencloseSwitch: UISwitch!

    public var classdetail = ClassModel()
    @IBOutlet weak var ClassCheckBtn: UIButton!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var HeaderLable: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var StudentInfo: UIButton!
    @IBOutlet weak var statusview: UIView!
    @IBAction func back(_ sender: Any) {
        let home = self.storyboard?.instantiateViewController(identifier: "home")
        self.view.window?.rootViewController = home
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detail = ",classdetail)
        setdata()
        HeaderLable.font = UIFont(name: Constants.ConstantFont.Medium, size: 24)
        HeaderLable.textColor = UIColor.white
        titleLable.font = UIFont(name: Constants.ConstantFont.BOLD, size: 22)
        card.layer.cornerRadius = 15
        card.layer.shadowColor = UIColor.gray.cgColor
        card.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        card.layer.shadowOpacity = 0.5
        card.layer.masksToBounds = false
        card.layer.shadowRadius = 5
        card.backgroundColor = UIColor.white
        StudentInfo.titleLabel?.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        ClassCheckBtn.titleLabel?.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        StudentInfo.isHidden = true
        opencloseSwitch.isHidden = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        showBtnPermission()
        setActiveBtn()
    }
    
    private func setActiveBtn() {
        if let active = classdetail.classactive {
            opencloseSwitch.setOn(active, animated: true)
        }
    }
    
    //เช็คtypeและซ่อนปุ่มaddclass
    fileprivate func showBtnPermission() {
        let type = DatabaseManager.shared.checkType()
        switch type {
        case "teacher" :
            StudentInfo.isHidden = false
            ClassCheckBtn.isEnabled = false
            ClassCheckBtn.setTitle("ผู้ใช้นี้ไม่สามารถเช็คชื่อได้", for: .normal)
            opencloseSwitch.isHidden = false
        default :
            StudentInfo.isHidden = true
            opencloseSwitch.isHidden = true
        }
    }
    
    @IBAction func openSwitch(_ sender: Any) {
        if opencloseSwitch.isOn {
            print("open")
            DatabaseManager.shared.setActiveClassOpen(docID: classdetail.doccumentID ?? "")
        } else {
            print("close")
            DatabaseManager.shared.setActiveClassClose(docID: classdetail.doccumentID ?? "")
        }
    }
    
    private func setdata() {
        subjectIDLB.text = classdetail.classID
        subjectNameLB.text = classdetail.className
        subjectTimeLB.text = classdetail.classtime
        studentCountLB.text =  "\(classdetail.studentList?.count ?? 0)"
    }

    @IBAction func studentInfo(_ sender: Any) {
        let stdInfo = self.storyboard?.instantiateViewController(identifier: "stdtable")
        self.view.window?.rootViewController = stdInfo
        self.navigationController?.popToRootViewController(animated: true)
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
