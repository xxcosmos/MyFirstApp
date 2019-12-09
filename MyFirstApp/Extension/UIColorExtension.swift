//
//  UIColorExtension.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2019/12/9.
//  Copyright © 2019 xiaoyuu. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func hexColor(_ hexValue: Int, alphaValue:Double) -> UIColor {
        let redValue = CGFloat((hexValue & 0xFF0000) >> 16) / 255
        let greenValue = CGFloat((hexValue & 0x00FF00) >> 8) / 255
        let blueValue = CGFloat((hexValue & 0x0000FF)) / 255
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: CGFloat(alphaValue))
    }
    
    static func hexColor(_ hexValue: Int) -> UIColor {
        return hexColor(hexValue, alphaValue: 1)
    }
    
    convenience  init(_ hexValue: Int, alphaValue:Double) {
        let redValue = CGFloat((hexValue & 0xFF0000) >> 16) / 255
        let greenValue = CGFloat((hexValue & 0x00FF00) >> 8) / 255
        let blueValue = CGFloat((hexValue & 0x0000FF)) / 255
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: CGFloat(alphaValue))
    }
    convenience init(_ hexValue: Int){
        self.init(hexValue,alphaValue: 1)
    }
    
    /// UIColor 转图片
    func toImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
