//
//  HomeViewController.swift
//  classattendanceproject
//
//  Created by Parisut Supchokpool on 1/11/2564 BE.
//

import UIKit
import Firebase
import CloudKit

class HomeViewController: UIViewController, UITableViewDataSource,UITableViewDelegate  {
//    @IBOutlet weak var headerlable: UILabel!
    
    @IBOutlet weak var headerlable: UILabel!
    private var classlist = [ClassModel]()
    var allclass = [ClassModel]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classlist.count ?? 0
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectcard", for: indexPath) as! SubjectCardCell
//        cell.subject(id: subjectid[indexPath.row], name: subjectname[indexPath.row], time: subjecttime[indexPath.row], stdcount: stdcount[indexPath.row], checkstat: checkstats[indexPath.row])
        cell.subject(id: classlist[indexPath.row].classID ?? "", name: classlist[indexPath.row].className ?? "", time: classlist[indexPath.row].classtime ?? "", stdcount: "\(classlist[indexPath.row].studentList?.count ?? 0)" ?? "", checkstat: "\(classlist[indexPath.row].classactive ?? false )" ?? "")
//        print("cell = ",classlist[indexPath.row].classID)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ontap(gesture:)))
        cell.tag = indexPath.row
        cell.addGestureRecognizer(tapGesture)
        return cell
    }
    
    @objc func ontap(gesture:UITapGestureRecognizer) {
        if let cell = gesture.view {
            print(cell.tag)
            performSegue(withIdentifier: "show_class", sender: classlist[cell.tag])
            //ฟ้อนทำด้วย //ดันหน้าที่ถูกต้อง จะได้ไม่ซ้อน พุช
//            let vc = self.storyboard?.instantiateViewController(identifier: "createclass") as? CreateClass
//            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func profileButton(_ sender: Any) {
        let Profile = self.storyboard?.instantiateViewController(identifier: "profile") as? ProfileViewController
        self.view.window?.rootViewController = Profile
        //self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func addClass(_ sender: Any) {
        let Create = self.storyboard?.instantiateViewController(identifier: "createclass") as? CreateClass
        self.view.window?.rootViewController = Create
    }
    
    @IBAction func joinClass(_ sender: Any) {
        let Join = self.storyboard?.instantiateViewController(identifier: "joinclass") as? JoinClass
        Join?.allclassdata = allclass
        self.view.window?.rootViewController = Join
        
    }
    
    @IBOutlet weak var joinClassbtn: UIButton!
    @IBOutlet weak var permissionbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SubjectClass", bundle: nil), forCellReuseIdentifier: "subjectcard")
        getClassData()
        print("checkid = ", DatabaseManager.shared.checkUserID())
        print("checktype = ", DatabaseManager.shared.checkType())
        headerlable.font = UIFont(name: Constants.ConstantFont.Medium, size: 24)
        headerlable.textColor = UIColor.white
        permissionbtn.isHidden = true
        addClassCustomBtn.layer.shadowColor = UIColor.gray.cgColor
        addClassCustomBtn.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        addClassCustomBtn.layer.shadowOpacity = 0.8
        addClassCustomBtn.layer.masksToBounds = false
        addClassCustomBtn.layer.shadowRadius = 5
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_class" {
            //ส่งค่า
            let subjectinfo = segue.destination as! SubjectInfo
            subjectinfo.classdetail = sender as! ClassModel
        }
    }
    
    @IBOutlet weak var addClassCustomBtn: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        setaddClassButton()
        //เช็คหน้าซ้อน
        print(self.navigationController?.viewControllers.count)
        // ลบหน้าตามindex(count)
        //self.navigationController?.viewControllers.remove(at:navigationController!.viewControllers.count)
        //กลับหน้า
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
    //เช็คtypeและซ่อนปุ่มaddclass
    fileprivate func setaddClassButton() {
        let type = DatabaseManager.shared.checkType()
        switch type {
        case "teacher" :
            permissionbtn.isHidden = false
            joinClassbtn.isHidden = true
        default :
            permissionbtn.isHidden = true
            
        }
    }
    
    func getClassData() {
        DatabaseManager.shared.getalldata(completion: { [weak self] (result) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let classdata):
//                    print("class = ",classdata)
                    var classSelected = [ClassModel]()
                    if DatabaseManager.shared.checkType() == "teacher" {
                        classSelected = DatabaseManager.shared.selectedClassTeacher(number: DatabaseManager.shared.checkUserID(), classdata: classdata)
                    }
                    else if DatabaseManager.shared.checkType() == "student" {
                        classSelected = DatabaseManager.shared.selectedClassStudent(number: DatabaseManager.shared.checkUserID(), classdata: classdata)
                    }
                //    print("class = ",classSelected)
                    self?.classlist = classSelected
                    self?.allclass = classdata
                    self?.setdata()
                    self?.getalldata()
                case .failure(let error):
                    print("ERROR",error)
                }
            }
        })
    }
    
    func getalldata() {
//        print("allclass = ",allclass)
//        for i in allclass {
//            print("studentlist = ", i.studentList)
//        }
    }
    func setdata () {
        //print("setdata classlist = ",classlist)
        tableView.reloadData()
    }
    
        
}
    
