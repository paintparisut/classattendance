//
//  SubjectInfo.swift
//  classattendanceproject
//
//  Created by TAPE on 14/11/2564 BE.
//

import UIKit

class SubjectInfo: UIViewController {

    @IBOutlet weak var HeaderLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        HeaderLable.font = UIFont(name: Constants.ConstantFont.Medium, size: 28)
        HeaderLable.textColor = UIColor.white
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
