//
//  CreateClass.swift
//  classattendanceproject
//
//  Created by TAPE on 14/11/2564 BE.
//

import UIKit

class CreateClass: UIViewController {

    @IBOutlet weak var classID: CustomTextField!
    @IBOutlet weak var className: CustomTextField!
    @IBOutlet weak var classLect: CustomTextField!
    @IBOutlet weak var classTime: CustomTextField!
    @IBOutlet weak var classDate: CustomTextField!
    @IBOutlet weak var headerlable: UILabel!

    
    @IBAction func back(_ sender: Any) {
        let home = self.storyboard?.instantiateViewController(identifier: "home")
        self.view.window?.rootViewController = home
    }
    
    func CheckGuard() -> Bool {
        if classID.text == "" || classTime.text == "" || className.text == "" || classDate.text == "" || classLect.text == "" {
            return false
        }
        return true
    }
        
    @IBOutlet weak var PickerTime: UIPickerView!
    @IBAction func Picker(_ sender: Any) {
        
    }
    
    @IBAction func addclass(_ sender: Any) {
        guard  CheckGuard() else {
            let alert = UIAlertController(title: "Error", message: "กรอกข้อมูลให้ครบถ้วน", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        DatabaseManager.shared.createClass(class_id: classID.text!, class_name: className.text!, class_lecName: classLect.text!, class_time: classTime.text!, class_date: classDate.text!) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let classdata):
                    DatabaseManager.shared.saveInvite(type: classdata.inviteCode!)
                    print("classdata = ",classdata)
                    DatabaseManager.shared.updateDocIDClass()
                    let vc = self?.storyboard?.instantiateViewController(identifier: "invitecode")
                    self?.view.window?.rootViewController = vc
                case .failure(let error):
                    print("ERROR",error) //.localizedDescription
//                    if self?.classID.text == "" || self?.classTime.text == "" || self?.className.text == "" || self?.classDate.text == "" || self?.classLect.text == "" {
//                        print("dfdfdfdf")
                    }
                }
            }
        }
    
    let datepicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerlable.font = UIFont(name: Constants.ConstantFont.Medium, size: 24)
        classID.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        classDate.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        classLect.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        className.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        classTime.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "hh:mm"
        classTime.text = formatter.string(from: time)
        
        let timepicker = UIDatePicker()
        timepicker.datePickerMode = .time
        timepicker.addTarget(self, action: #selector(timePickerValueChange(sender:)), for: UIControl.Event.valueChanged)
        timepicker.frame.size = CGSize(width: 0, height: 250)
        classTime.inputView = timepicker
    }
    
    @objc func timePickerValueChange(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "hh:mm"
        classTime.text = formatter.string(from: sender.date)
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
