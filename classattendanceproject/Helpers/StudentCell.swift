//
//  StudentCell.swift
//  classattendanceproject
//
//  Created by TAPE on 1/12/2564 BE.
//

import UIKit

class StudentCell: UITableViewCell {

    @IBOutlet weak var stdName: UILabel!
    @IBOutlet weak var Card: UIView!
    @IBOutlet weak var statusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func student(name: String, statusC:String) {
//        var checkclass:String = ""
        stdName.text = name
//        checkclass = "\(status)"
        stdName.font = UIFont(name: Constants.ConstantFont.Medium, size: 28)
        stdName.textColor = UIColor(cgColor: Constants.GraphicColors.COSCI_BLUEPMR_COLOR)
        Card.layer.cornerRadius = 15
        Card.layer.shadowColor = UIColor.gray.cgColor
        Card.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        Card.layer.shadowOpacity = 0.5
        Card.layer.masksToBounds = false
        Card.layer.shadowRadius = 5
        Card.backgroundColor = UIColor.white
        print(statusC)
        if statusC == "true" {
            let status = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 65))
            status.backgroundColor = UIColor(cgColor: Constants.GraphicColors.COSCI_SUCCESS_COLOR)
            status.layer.cornerRadius = 13
            status.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            statusView.addSubview(status)
        }
        else if statusC == "false" {
            let status = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 65))
            status.backgroundColor = UIColor(cgColor: Constants.GraphicColors.COSCI_ERROR_COLOR)
            status.layer.cornerRadius = 13
            status.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            statusView.addSubview(status)
        }
    }
}
