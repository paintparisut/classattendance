//
//  StudentViewController.swift
//  classattendanceproject
//
//  Created by TAPE on 1/12/2564 BE.
//

import UIKit

class StudentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    var test:[String] = ["TEST"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "student", for: indexPath) as! StudentCell
        cell.student(name: test[indexPath.row])
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "Student", bundle: nil), forCellReuseIdentifier: "student")
        tableview.rowHeight = 100
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
