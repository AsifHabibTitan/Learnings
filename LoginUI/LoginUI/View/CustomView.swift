//
//  CustomView.swift
//  LoginUI
//
//  Created by Asif Habib on 21/07/23.
//

import UIKit

class CustomView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width/8
//        self.bounds = self.frame.insetBy(dx: 10, dy: 10)
    }

}
