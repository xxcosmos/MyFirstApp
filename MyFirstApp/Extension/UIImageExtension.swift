//
//  UIImageExtension.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/3/3.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

public extension UIImage {
    func roundCorner(cornerRadius: CGFloat) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        let ctx = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        ctx?.addPath(path)
        ctx?.clip()
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
