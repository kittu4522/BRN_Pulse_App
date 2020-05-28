//
//  ExtensionFile.swift
//  Pulse_Project
//
//  Created by RAM on 09/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit

extension UIView
{
    func setShadow()
    {
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 3.0
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 5.0
    }
}


extension UITextField
{
    func setIcon(image: UIImage)
    {
        let iconImageView = UIImageView(frame: CGRect(x: 10, y: 5, width: 30, height: 20))
        iconImageView.image = image
        let txtView:UIView = UIView(frame: CGRect(x: 20, y: 0, width: 40, height: 30))
        txtView.addSubview(iconImageView)
        leftView = txtView
        leftViewMode = .always
    }
    func setBorder()
    {
        self.clipsToBounds = true
        self.layer.cornerRadius = 25
        self.layer.cornerCurve = .circular
        self.layer.borderColor = #colorLiteral(red: 0.9911785722, green: 0.1457401514, blue: 0.01364050619, alpha: 1)
        self.layer.borderWidth = 2.0
    }
}

