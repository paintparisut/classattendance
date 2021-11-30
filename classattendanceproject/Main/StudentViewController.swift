//
//  StudentViewController.swift
//  classattendanceproject
//
//  Created by TAPE on 1/12/2564 BE.
//

import UIKit

class StudentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    public var classAttendanceData = [ClassAttendanceModel]()
   // var classdata = ClassModel()
    
    @IBOutlet weak var tableview: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return classAttendanceData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "student", for: indexPath) as! StudentCell
        cell.student(name: classAttendanceData[indexPath.row].studentNumber ?? "")
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       // print("classdata",classdata)
        setdata()
        tableview.register(UINib(nibName: "Student", bundle: nil), forCellReuseIdentifier: "student")
        tableview.rowHeight = 100
        print("test",classAttendanceData)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func back(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "stdInfo") as! SubjectInfo
        //vc.classdetail = classdata
        self.view.window?.rootViewController = vc
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setdata() {
        tableview.reloadData()
    }

}
