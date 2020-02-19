//
//  CommonExtension.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/1/20.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import UIKit

public extension Array {
    
    func getRandom() -> Iterator.Element? {
        guard count > 0 else{return nil}
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
}



public extension UIColor {
    
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
    
    func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (red * 255, green * 255, blue * 255)
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

extension UINavigationController {
    
    func getPreviousViewController() -> UIViewController? {
        guard self.navigationController?.viewControllers != nil else {
            return nil
        }
        
        guard (self.navigationController?.viewControllers.count)! > 1 else {
            return nil
        }
        
        guard self.navigationController?.topViewController == self else {
            return nil
        }
        
        let count = self.navigationController?.viewControllers.count
        return ((self.navigationController?.viewControllers[count!-2])!)
        
    }
}

extension String {
    func getMD5() -> String {
        let str = self.cString(using: .utf8)
        let strLength = CC_LONG(self.lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLength, result)
        
        
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate()
        return String(format: hash as String)
    }
}
