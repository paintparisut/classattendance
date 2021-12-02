//
//  SubjectInfo.swift
//  classattendanceproject
//
//  Created by TAPE on 14/11/2564 BE.
//

import UIKit

class SubjectInfo: UIViewController {

    public var classdetail = ClassModel()
    public var classAttendanceList = [ClassAttendanceModel]()
    
    
    @IBOutlet weak var cardStd: UIView!
    @IBOutlet weak var ChartPie: PieChartView!
    @IBOutlet weak var subjectIDLB: UILabel!
    @IBOutlet weak var subjectNameLB: UILabel!
    @IBOutlet weak var subjectTimeLB: UILabel!
    @IBOutlet weak var studentCountLB: UILabel!
    @IBOutlet weak var opencloseSwitch: UISwitch!
    @IBOutlet weak var allStdLable: UILabel!
    @IBOutlet weak var allStdPresent: UILabel!
    @IBOutlet weak var allStdAbsent: UILabel!
    @IBOutlet weak var allStdCount: UILabel!
    @IBOutlet weak var allStdPresentCount: UILabel!
    @IBOutlet weak var allStdAbsentCount: UILabel!
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
    
    @IBOutlet weak var InviteTitleLB: UILabel!
    @IBOutlet weak var InviteCodeTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setdata()
        HeaderLable.font = UIFont(name: Constants.ConstantFont.Medium, size: 24)
        HeaderLable.textColor = UIColor.white
        titleLable.font = UIFont(name: Constants.ConstantFont.BOLD, size: 22)
        InviteTitleLB.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        card.layer.cornerRadius = 15
        card.layer.shadowColor = UIColor.gray.cgColor
        card.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        card.layer.shadowOpacity = 0.5
        card.layer.masksToBounds = false
        card.layer.shadowRadius = 5
        card.backgroundColor = UIColor.white
        StudentInfo.titleLabel?.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        ClassCheckBtn.titleLabel?.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        TeacherViewPermission.isHidden = true
        allStdLable.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        allStdPresent.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        allStdAbsent.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        allStdCount.font = UIFont(name: Constants.ConstantFont.Medium, size: 16)
        allStdPresentCount.font = UIFont(name: Constants.ConstantFont.Medium, size: 16)
        allStdAbsentCount.font = UIFont(name: Constants.ConstantFont.Medium, size: 16)
        cardStd.layer.cornerRadius = 15
        subjectIDLB.font = UIFont(name: Constants.ConstantFont.Medium, size: 28)
        subjectNameLB.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        subjectNameLB.textColor = UIColor(cgColor: Constants.GraphicColors.COSCI_GRAY_COLOR)
        subjectTimeLB.textColor = UIColor(cgColor: Constants.GraphicColors.COSCI_GRAY_COLOR)
        subjectTimeLB.font = UIFont(name: Constants.ConstantFont.Medium, size: 16)
        studentCountLB.font = UIFont(name: Constants.ConstantFont.Medium, size: 16)
        studentCountLB.textColor = UIColor(cgColor: Constants.GraphicColors.COSCI_GRAY_COLOR)
        InviteCodeTf.text = classdetail.inviteCode
        InviteCodeTf.font = UIFont(name: Constants.ConstantFont.Medium, size: 18)
        opencloseSwitch.isHidden = true
        let status = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 150))
        status.backgroundColor = UIColor(cgColor: Constants.GraphicColors.COSCI_BLUEPMR_COLOR)
        status.layer.cornerRadius = 13
        status.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        statusview.addSubview(status)
        showBtnPermission()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setdata()
        setActiveBtn()
        getAllClassAttendance()
        setClassAttendancedata()
        
//        closeBtnCheck()
    }

    
    @IBAction func studentCheckIn(_ sender: Any) {
        DatabaseManager.shared.CheckStundet(classData: classAttendanceList)
        getAllClassAttendance()
        showBtnPermission()
    }
    
    private func setActiveBtn() {
        if let active = classdetail.classactive {
            opencloseSwitch.setOn(active, animated: true)
        }
    }

    
    //เช็คtypeและซ่อนปุ่มaddclass
    fileprivate func showBtnPermission() {
        let type = DatabaseManager.shared.checkType()

        if type == "teacher" {
            TeacherViewPermission.isHidden = false
            ClassCheckBtn.isEnabled = false
            ClassCheckBtn.setTitle("ผู้ใช้นี้ไม่สามารถเช็คชื่อได้", for: .normal)
            opencloseSwitch.isHidden = false
        }
        else if type == "student" {
            TeacherViewPermission.isHidden = true
            opencloseSwitch.isHidden = true
            
            for i in classAttendanceList {
                if i.statusactive! == true {
                    ClassCheckBtn.isEnabled = false
                    ClassCheckBtn.setTitle("เช็คชื่อเรียบร้อย", for: .normal)
                }
            }
        }
    }
    
    @IBAction func openSwitch(_ sender: Any) {
        if opencloseSwitch.isOn {
            print("open")
            DatabaseManager.shared.setActiveClassOpen(docID: classdetail.doccumentID ?? "")
        } else {
            print("close")
            DatabaseManager.shared.setActiveClassClose(docID: classdetail.doccumentID ?? "")
            DatabaseManager.shared.setFalseStundet(classData: classAttendanceList)
        }
    }
    
    private func setdata() {
        subjectIDLB.text = classdetail.classID
        subjectNameLB.text = classdetail.className
        subjectTimeLB.text = classdetail.classtime
        studentCountLB.text =  "\(classdetail.studentList?.count ?? 0)"
        allStdCount.text = "\(classdetail.studentList?.count ?? 0)"
        //showBtnPermission()
    }

    @IBAction func studentInfo(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "stdtable") as? StudentViewController
        vc?.classAttendanceData = classAttendanceList
        self.navigationController?.pushViewController(vc!, animated: true)

    }

    @IBAction func deleteClass(_ sender: Any) {
        DatabaseManager.shared.deleteClass(classDocID: classdetail.doccumentID ?? "")
        DatabaseManager.shared.deleteClassAttendance(classInvite: classdetail.inviteCode ?? "", classAttendanceData: classAttendanceList)
        let home = self.storyboard?.instantiateViewController(identifier: "home")
        self.view.window?.rootViewController = home
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    func getAllClassAttendance() {
        DatabaseManager.shared.getallClassAttenDancedata(completion: { [weak self] (result) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let classdata):
//                    print("class = ",classdata)
                    var classSelected = [ClassAttendanceModel]()
                    if DatabaseManager.shared.checkType() == "teacher" {
                        classSelected = DatabaseManager.shared.selectedClassAttendanceTeacher(inviteCode:self?.classdetail.inviteCode ?? "", classAttendance: classdata)
                    }
                    else if DatabaseManager.shared.checkType() == "student" {
                        classSelected = DatabaseManager.shared.selectedClassAttendanceStudent(inviteCode: self?.classdetail.inviteCode ?? "", classAttendance: classdata)
                    }
                //    print("class = ",classSelected)
                    self?.classAttendanceList = classSelected
                    self?.setClassAttendancedata()
                    self?.showBtnPermission()
                case .failure(let error):
                    print("ERROR",error)
                }
            }
        })
    }
    
    func setClassAttendancedata() {
        print("student in class = ",classAttendanceList)
        print("student = \(classAttendanceList.count) checked = \(getDataStudentinClassCheck(classdata: classAttendanceList)) absent = \(getDataStudentinClassAbsent(classdata: classAttendanceList)) ")
        
        self.ChartPie.addAnimation = true
        self.ChartPie.animationDuration = 1.0
        self.ChartPie.sperator = 3
        self.ChartPie.drawChart([PieChartItem (UIColor(cgColor:Constants.GraphicColors.COSCI_BLUEPMR_COLOR), CGFloat(getDataStudentinClassCheck(classdata: classAttendanceList))),
                                 PieChartItem (UIColor(cgColor:Constants.GraphicColors.COSCI_ERROR_COLOR),CGFloat(getDataStudentinClassAbsent(classdata: classAttendanceList)))])
        allStdPresentCount.text = "\(getDataStudentinClassCheck(classdata: classAttendanceList))"
        allStdAbsentCount.text = "\(getDataStudentinClassAbsent(classdata: classAttendanceList))"

    }
    
    
    func getDataStudentinClassCheck(classdata:[ClassAttendanceModel]) -> Int {
        var count = 0
        for i in classdata {
            if i.statusactive == true {
                count += 1
            }
        }
        return count
    }

    func getDataStudentinClassAbsent(classdata:[ClassAttendanceModel]) -> Int {
        var count = 0
        for i in classdata {
            if i.statusactive == false {
                count += 1
            }
        }
        return count
    }

    
    @IBOutlet weak var TeacherViewPermission: UIView!
    @IBOutlet weak var DeleteClassOutlet: UIButton!
}

