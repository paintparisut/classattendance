//
//  StudentCell.swift
//  classattendanceproject
//
//  Created by TAPE on 1/12/2564 BE.
//

import UIKit

class StudentCell: UITableViewCell {

    @IBOutlet weak var stdName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func student(name: String) {
        stdName.text = name
    }

}
