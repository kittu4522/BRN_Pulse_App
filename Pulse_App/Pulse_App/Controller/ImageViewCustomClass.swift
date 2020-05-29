//
//  UIViewCustomClass.swift
//  Pulse_App
//
//  Created by RAM on 29/05/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class ImageViewCustomClass:UIImageView
{
    @IBInspectable var cornerRadius: CGFloat = 0
        {
       didSet
       {
           layer.cornerRadius = cornerRadius
           layer.masksToBounds = cornerRadius > 0
       }
    }
    @IBInspectable var borderWidth: CGFloat = 0
        {
       didSet
       {
            layer.borderWidth = borderWidth
       }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear
        {
       didSet
       {
        layer.borderColor = borderColor.cgColor
       }
    }
    
}
