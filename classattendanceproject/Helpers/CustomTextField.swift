//
//  CustomTextField.swift
//  classattendanceproject
//
//  Created by TAPE on 25/10/2564 BE.
//

import UIKit

class CustomTextField: UITextField {
    
//    func customTfPad() {
//        let padView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
//        self.leftView = padView
//        self.leftViewMode = .always
//    }
//
//    func customTfBroder() {
//        self.layer.shadowColor = UIColor.darkGray.cgColor
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowRadius = 0.0
//    }
    
    func CustomTf() {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = Constants.GraphicColors.COSCI_BLUEPMR_COLOR
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        CustomTf()
    }
    required public init?(coder tf: NSCoder) {
        super.init(coder: tf)
        CustomTf()
    }
}
