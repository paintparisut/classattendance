//
//  SubjectCardCell.swift
//  classattendanceproject
//
//  Created by TAPE on 6/11/2564 BE.
//

import UIKit

class SubjectCardCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var SubjectName: UILabel!
    @IBOutlet weak var SubjectID: UILabel!
    @IBOutlet weak var SubjectTime: UILabel!
    @IBOutlet weak var StudentCount: UILabel!
    
    func subject(id: String, name: String, time: String, stdcount: String, checkstat: String) {
        print("id = \(id) , name \(name), time = \(time) studentcount = \(stdcount) check = \(checkstat)")
        SubjectID.text = id
        SubjectName.text = name
        SubjectTime.text = time
        StudentCount.text = stdcount
        SubjectID.font = UIFont(name: Constants.ConstantFont.Medium, size: 28)
        SubjectID.textColor = UIColor(cgColor: Constants.GraphicColors.COSCI_BLUEPMR_COLOR)
        SubjectName.font = UIFont(name: Constants.ConstantFont.Regular, size: 18)
        SubjectName.textColor = UIColor(cgColor: Constants.GraphicColors.COSCI_GRAY_COLOR)
        SubjectTime.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        SubjectTime.textColor = UIColor(cgColor: Constants.GraphicColors.COSCI_GRAY_COLOR)
        StudentCount.font = UIFont(name: Constants.ConstantFont.Regular, size: 16)
        StudentCount.textColor = UIColor(cgColor: Constants.GraphicColors.COSCI_GRAY_COLOR)
        checkbtn.textColor = UIColor.white
        checkbtn.font = UIFont(name: Constants.ConstantFont.Medium, size: 16)
        card.layer.cornerRadius = 15
        card.layer.shadowColor = UIColor.gray.cgColor
        card.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        card.layer.shadowOpacity = 0.5
        card.layer.masksToBounds = false
        card.layer.shadowRadius = 5
        card.backgroundColor = UIColor.white
        
        if checkstat == "true" {
            let status = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 150))
            status.backgroundColor = UIColor(cgColor: Constants.GraphicColors.COSCI_BLUEPMR_COLOR)
            status.layer.cornerRadius = 13
            status.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            ststusview.addSubview(status)
            let checkview = UIView(frame: CGRect(x: 0, y: 0, width: 160, height: 40))
            checkview.backgroundColor = UIColor(cgColor: Constants.GraphicColors.COSCI_BLUEPMR_COLOR)
            checkview.layer.cornerRadius = 13
            checkview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
            check.addSubview(checkview)
            checkbtn.layer.zPosition = 1
            checkbtn.text = "เช็คชื่อ"
            studentClass.tintColor = UIColor(cgColor: Constants.GraphicColors.COSCI_BLUEPMR_COLOR)

        }
        else if checkstat == "false" {
            let status = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 150))
            status.backgroundColor = UIColor(cgColor: Constants.GraphicColors.COSCI_ERROR_COLOR)
            status.layer.cornerRadius = 13
            status.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            ststusview.addSubview(status)
            let checkview = UIView(frame: CGRect(x: 0, y: 0, width: 160, height: 40))
            checkview.backgroundColor = UIColor(cgColor: Constants.GraphicColors.COSCI_ERROR_COLOR)
            checkview.layer.cornerRadius = 13
            checkview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
            check.addSubview(checkview)
            checkbtn.layer.zPosition = 1
            checkbtn.text = "ยังไม่เปิดให้เช็คชื่อ"
            SubjectID.textColor = UIColor(cgColor: Constants.GraphicColors.COSCI_ERROR_COLOR)
            studentClass.tintColor = UIColor(cgColor: Constants.GraphicColors.COSCI_ERROR_COLOR)
        }
        else if checkstat == "2" {
            let status = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 150))
            status.backgroundColor = UIColor(cgColor: Constants.GraphicColors.COSCI_SUCCESS_COLOR)
            status.layer.cornerRadius = 13
            status.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            ststusview.addSubview(status)
            let checkview = UIView(frame: CGRect(x: 0, y: 0, width: 160, height: 40))
            checkview.backgroundColor = UIColor(cgColor: Constants.GraphicColors.COSCI_SUCCESS_COLOR)
            checkview.layer.cornerRadius = 13
            checkview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
            check.addSubview(checkview)
            checkbtn.layer.zPosition = 1
            checkbtn.text = "เช็คชื่อสำเร็จ"
            SubjectID.textColor = UIColor(cgColor: Constants.GraphicColors.COSCI_SUCCESS_COLOR)
            studentClass.tintColor = UIColor(cgColor: Constants.GraphicColors.COSCI_SUCCESS_COLOR)
        }
    }
    
    
    @IBOutlet weak var ststusview: UIView!
    @IBOutlet weak var check: UIView!
    @IBOutlet weak var checkbtn: UILabel!
    @IBOutlet weak var studentClass: UIImageView!
}
